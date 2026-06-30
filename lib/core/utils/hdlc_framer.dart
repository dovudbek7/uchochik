import 'dart:typed_data';

import 'package:uchochik/core/utils/crc16.dart';

// ── HDLC frame model ──────────────────────────────────────────────────────────

class HdlcFrame {
  const HdlcFrame({
    required this.destAddress,
    required this.srcAddress,
    required this.control,
    this.info,
  });

  final List<int> destAddress;
  final List<int> srcAddress;
  final int control;
  final Uint8List? info;

  // U-frame predicates (mask out P/F bit 4)
  bool get isUA => (control & 0xEF) == 0x73;
  bool get isSNRM => (control & 0xEF) == 0x93;
  bool get isDISC => (control & 0xEF) == 0x53;
  bool get isDM => (control & 0xEF) == 0x0F;
  bool get isFRMR => (control & 0xEF) == 0x87;

  // I-frame: bit 0 = 0
  bool get isIFrame => (control & 0x01) == 0;

  /// Send sequence number (I-frames only).
  int get ns => isIFrame ? (control >> 1) & 0x07 : 0;

  /// Receive sequence number (I-frames only).
  int get nr => isIFrame ? (control >> 5) & 0x07 : 0;
}

// ── HDLC framer ───────────────────────────────────────────────────────────────

abstract final class HdlcFramer {
  // U-frame control bytes
  static const _ctrlSNRM = 0x93;
  static const _ctrlDISC = 0x53;

  // SNRM parameters: max info TX=128, RX=128, window TX/RX=1
  static const _snrmInfo = <int>[
    0x81, 0x80, 0x12,
    0x05, 0x02, 0x00, 0x80, // max info TX = 128
    0x06, 0x02, 0x00, 0x80, // max info RX = 128
    0x07, 0x04, 0x00, 0x00, 0x00, 0x01, // window TX = 1
    0x08, 0x04, 0x00, 0x00, 0x00, 0x01, // window RX = 1
  ];

  // ── Public builders ─────────────────────────────────────────────────────────

  static Uint8List buildSnrm({
    required int serverLogical,
    required int serverPhysical,
    required int clientSap,
  }) =>
      _build(
        serverLogical: serverLogical,
        serverPhysical: serverPhysical,
        clientSap: clientSap,
        control: _ctrlSNRM,
        info: Uint8List.fromList(_snrmInfo),
      );

  static Uint8List buildDisc({
    required int serverLogical,
    required int serverPhysical,
    required int clientSap,
  }) =>
      _build(
        serverLogical: serverLogical,
        serverPhysical: serverPhysical,
        clientSap: clientSap,
        control: _ctrlDISC,
        info: null,
      );

  static Uint8List buildIFrame({
    required int serverLogical,
    required int serverPhysical,
    required int clientSap,
    required int ns,
    required int nr,
    required Uint8List info,
  }) {
    // I-frame control: bit0=0, bits1-3=NS, bit4=P/F=0, bits5-7=NR
    final ctrl = ((nr & 7) << 5) | ((ns & 7) << 1);
    return _build(
      serverLogical: serverLogical,
      serverPhysical: serverPhysical,
      clientSap: clientSap,
      control: ctrl,
      info: info,
    );
  }

  // ── Parser ──────────────────────────────────────────────────────────────────

  /// Returns null on CRC mismatch or malformed frame.
  static HdlcFrame? parse(Uint8List bytes) {
    if (bytes.length < 5 || bytes.first != 0x7E || bytes.last != 0x7E) {
      return null;
    }
    final content = _unstuff(bytes.sublist(1, bytes.length - 1));
    if (content.length < 6) return null;

    // Parse addresses
    var offset = 2; // skip format bytes
    final dest = _readAddress(content, offset);
    offset += dest.length;
    if (offset >= content.length) return null;
    final src = _readAddress(content, offset);
    offset += src.length;
    if (offset >= content.length) return null;

    final ctrl = content[offset++];

    // Verify HCS
    final hcsData = content.sublist(0, offset);
    final expectedHcs = [content[offset], content[offset + 1]];
    if (!Crc16.verify(hcsData, expectedHcs)) return null;
    offset += 2;

    Uint8List? info;
    if (offset < content.length - 2) {
      info = Uint8List.fromList(content.sublist(offset, content.length - 2));
      final fcsData = content.sublist(0, content.length - 2);
      final expectedFcs = content.sublist(content.length - 2);
      if (!Crc16.verify(fcsData, expectedFcs)) return null;
    }

    return HdlcFrame(
      destAddress: dest,
      srcAddress: src,
      control: ctrl,
      info: info,
    );
  }

  // ── Private helpers ─────────────────────────────────────────────────────────

  static Uint8List _build({
    required int serverLogical,
    required int serverPhysical,
    required int clientSap,
    required int control,
    Uint8List? info,
  }) {
    final dest = _encodeServer(serverLogical, serverPhysical);
    final src = _encodeClient(clientSap);
    final hasInfo = info != null && info.isNotEmpty;

    // Frame length = FORMAT(2) + DEST + SRC + CTRL(1) + HCS(2) [+ INFO + FCS(2)]
    final frameLen =
        2 + dest.length + src.length + 1 + 2 + (hasInfo ? info.length + 2 : 0);

    final fmt0 = 0xA0 | ((frameLen >> 8) & 0x07);
    final fmt1 = frameLen & 0xFF;

    // Build header for HCS computation
    final header = <int>[fmt0, fmt1, ...dest, ...src, control];
    final hcs = Crc16.bytes(header);

    final raw = <int>[...header, ...hcs];

    if (hasInfo) {
      raw.addAll(info);
      final fcs = Crc16.bytes(raw);
      raw.addAll(fcs);
    }

    return Uint8List.fromList([0x7E, ..._stuff(raw), 0x7E]);
  }

  /// Encode server (meter) address: 1-byte if logical==0, else 2 bytes.
  static List<int> _encodeServer(int logical, int physical) {
    if (logical == 0) return [(physical << 1) | 0x01];
    return [(logical << 1) & 0xFE, (physical << 1) | 0x01];
  }

  /// Encode client address: always 1 byte.
  static List<int> _encodeClient(int sap) => [(sap << 1) | 0x01];

  /// Read an HDLC address (variable length, LSB=1 on last byte).
  static List<int> _readAddress(List<int> data, int offset) {
    final addr = <int>[];
    while (offset < data.length) {
      final b = data[offset++];
      addr.add(b);
      if (b & 0x01 == 1) break;
    }
    return addr;
  }

  /// HDLC byte stuffing: 0x7E → 0x7D 0x5E, 0x7D → 0x7D 0x5D.
  static List<int> _stuff(List<int> data) {
    final out = <int>[];
    for (final b in data) {
      if (b == 0x7E) {
        out.add(0x7D);
        out.add(0x5E);
      } else if (b == 0x7D) {
        out.add(0x7D);
        out.add(0x5D);
      } else {
        out.add(b);
      }
    }
    return out;
  }

  /// HDLC byte unstuffing.
  static List<int> _unstuff(List<int> data) {
    final out = <int>[];
    var escape = false;
    for (final b in data) {
      if (escape) {
        out.add(b ^ 0x20);
        escape = false;
      } else if (b == 0x7D) {
        escape = true;
      } else {
        out.add(b);
      }
    }
    return out;
  }
}
