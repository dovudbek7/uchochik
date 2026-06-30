import 'dart:async';
import 'dart:typed_data';

import 'package:usb_serial/usb_serial.dart';
import 'package:uchochik/core/utils/hdlc_framer.dart';
import 'package:uchochik/features/connection/transport/i_transport.dart';

class SerialTransport implements ITransport {
  SerialTransport({
    required this.serverLogical,
    required this.serverPhysical,
    required this.clientSap,
    this.baudRate = 9600,
    this.requestTimeout = const Duration(seconds: 10),
    this.connectTimeout = const Duration(seconds: 15),
  });

  final int serverLogical;
  final int serverPhysical;
  final int clientSap;
  final int baudRate;
  final Duration requestTimeout;
  final Duration connectTimeout;

  UsbPort? _port;
  StreamSubscription<Uint8List>? _sub;
  final _buffer = <int>[];
  Completer<Uint8List>? _pending;

  // HDLC sequence numbers
  int _ns = 0; // send
  int _nr = 0; // expected receive

  final _statusController =
      StreamController<TransportStatus>.broadcast();

  @override
  bool get isConnected => _port != null;

  @override
  Stream<TransportStatus> get statusStream => _statusController.stream;

  @override
  Future<void> connect() async {
    _statusController.add(TransportStatus.connecting);
    try {
      final devices = await UsbSerial.listDevices();
      if (devices.isEmpty) throw StateError('No USB serial devices found');

      _port = await devices.first.create();
      if (_port == null) throw StateError('Failed to create USB port');

      await _port!.open();
      await _port!.setDTR(true);
      await _port!.setRTS(true);
      await _port!.setPortParameters(
        baudRate,
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      );

      _sub = _port!.inputStream?.listen(
        _onData,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      // HDLC link establishment: SNRM → UA
      await _sendSnrm();
      _statusController.add(TransportStatus.connected);
    } catch (e) {
      _statusController.add(TransportStatus.error);
      await _port?.close();
      _port = null;
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    // Send DISC to gracefully close the HDLC link
    try {
      final disc = HdlcFramer.buildDisc(
        serverLogical: serverLogical,
        serverPhysical: serverPhysical,
        clientSap: clientSap,
      );
      await _port?.write(Uint8List.fromList(disc));
    } catch (_) {}

    await _sub?.cancel();
    await _port?.close();
    _port = null;
    _pending?.completeError(StateError('Disconnected'));
    _pending = null;
    _buffer.clear();
    _ns = 0;
    _nr = 0;
    _statusController.add(TransportStatus.disconnected);
  }

  @override
  Future<Uint8List> request(
    Uint8List apdu, {
    Duration? timeout,
  }) async {
    if (_port == null) throw StateError('Not connected');
    if (_pending != null) throw StateError('Request already in progress');

    final completer = Completer<Uint8List>();
    _pending = completer;

    final iframe = HdlcFramer.buildIFrame(
      serverLogical: serverLogical,
      serverPhysical: serverPhysical,
      clientSap: clientSap,
      ns: _ns,
      nr: _nr,
      info: apdu,
    );
    _ns = (_ns + 1) & 7;

    await _port!.write(Uint8List.fromList(iframe));

    return completer.future.timeout(
      timeout ?? requestTimeout,
      onTimeout: () {
        _pending = null;
        throw TimeoutException('No response from meter', requestTimeout);
      },
    );
  }

  // ── SNRM handshake ────────────────────────────────────────────────────────

  Future<void> _sendSnrm() async {
    final completer = Completer<Uint8List>();
    _pending = completer;

    final snrm = HdlcFramer.buildSnrm(
      serverLogical: serverLogical,
      serverPhysical: serverPhysical,
      clientSap: clientSap,
    );
    await _port!.write(Uint8List.fromList(snrm));

    await completer.future.timeout(
      connectTimeout,
      onTimeout: () {
        _pending = null;
        throw TimeoutException('No UA response from meter (SNRM timeout)', connectTimeout);
      },
    );
  }

  // ── Data accumulation ─────────────────────────────────────────────────────

  void _onData(Uint8List data) {
    _buffer.addAll(data);
    _tryParseFrame();
  }

  void _tryParseFrame() {
    // Look for complete HDLC frame: 0x7E...0x7E (at least 2 flag bytes)
    final start = _buffer.indexOf(0x7E);
    if (start < 0) return;

    // Find closing flag — must be different from opening (at least 1 byte apart)
    final end = _buffer.indexOf(0x7E, start + 1);
    if (end < 0) return;

    final rawFrame = Uint8List.fromList(_buffer.sublist(start, end + 1));
    _buffer.removeRange(0, end + 1);

    final frame = HdlcFramer.parse(rawFrame);
    if (frame == null) {
      // Malformed — check if more data follows
      _tryParseFrame();
      return;
    }

    if (frame.isUA) {
      // SNRM response
      _pending?.complete(Uint8List(0));
      _pending = null;
    } else if (frame.isIFrame) {
      _nr = (frame.ns + 1) & 7;
      _pending?.complete(frame.info ?? Uint8List(0));
      _pending = null;
    }

    // Try to parse more if buffer still has data
    if (_buffer.isNotEmpty) _tryParseFrame();
  }

  void _onError(Object error) {
    _statusController.add(TransportStatus.error);
    _pending?.completeError(error);
    _pending = null;
  }

  void _onDone() {
    _port = null;
    _statusController.add(TransportStatus.disconnected);
    _pending?.completeError(StateError('Serial port closed'));
    _pending = null;
  }

  Future<void> dispose() async {
    await disconnect();
    await _statusController.close();
  }
}
