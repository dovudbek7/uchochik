import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:uchochik/core/utils/tcp_wrapper.dart';
import 'package:uchochik/features/connection/transport/i_transport.dart';

class TcpTransport implements ITransport {
  TcpTransport({
    required this.host,
    required this.port,
    this.connectTimeout = const Duration(seconds: 10),
    this.requestTimeout = const Duration(seconds: 10),
  });

  final String host;
  final int port;
  final Duration connectTimeout;
  final Duration requestTimeout;

  Socket? _socket;
  StreamSubscription<Uint8List>? _sub;
  final _buffer = <int>[];
  Completer<Uint8List>? _pending;

  final _statusController =
      StreamController<TransportStatus>.broadcast();

  @override
  bool get isConnected => _socket != null;

  @override
  Stream<TransportStatus> get statusStream => _statusController.stream;

  @override
  Future<void> connect() async {
    _statusController.add(TransportStatus.connecting);
    try {
      _socket = await Socket.connect(host, port, timeout: connectTimeout);
      _socket!.setOption(SocketOption.tcpNoDelay, true);
      _sub = _socket!.cast<Uint8List>().listen(
        _onData,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );
      _statusController.add(TransportStatus.connected);
    } catch (e) {
      _statusController.add(TransportStatus.error);
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    await _sub?.cancel();
    await _socket?.close();
    _socket?.destroy();
    _socket = null;
    _pending?.completeError(StateError('Disconnected'));
    _pending = null;
    _buffer.clear();
    _statusController.add(TransportStatus.disconnected);
  }

  @override
  Future<Uint8List> request(
    Uint8List apdu, {
    Duration? timeout,
  }) async {
    if (_socket == null) throw StateError('Not connected');
    if (_pending != null) throw StateError('Request already in progress');

    final completer = Completer<Uint8List>();
    _pending = completer;
    _socket!.add(TcpWrapper.wrap(apdu));

    return completer.future.timeout(
      timeout ?? requestTimeout,
      onTimeout: () {
        _pending = null;
        throw TimeoutException('No response from meter', requestTimeout);
      },
    );
  }

  void _onData(Uint8List data) {
    _buffer.addAll(data);
    try {
      final apdu = TcpWrapper.tryParse(_buffer);
      if (apdu != null && _pending != null && !_pending!.isCompleted) {
        _pending!.complete(apdu);
        _pending = null;
      }
    } catch (e) {
      _pending?.completeError(e);
      _pending = null;
      _buffer.clear();
    }
  }

  void _onError(Object error) {
    _statusController.add(TransportStatus.error);
    _pending?.completeError(error);
    _pending = null;
  }

  void _onDone() {
    _socket = null;
    _statusController.add(TransportStatus.disconnected);
    _pending?.completeError(StateError('Connection closed by remote'));
    _pending = null;
  }

  Future<void> dispose() async {
    await disconnect();
    await _statusController.close();
  }
}
