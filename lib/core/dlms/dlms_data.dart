import 'dart:convert';
import 'dart:typed_data';

import 'package:uchochik/core/dlms/ber.dart';

// ── DLMS data type tags (IEC 62056-53 §4) ────────────────────────────────────

abstract final class DlmsTag {
  static const nullData = 0x00;
  static const array = 0x01;
  static const structure = 0x02;
  static const boolean = 0x03;
  static const bitString = 0x04;
  static const int32 = 0x05;
  static const uint32 = 0x06;
  static const octetString = 0x09;
  static const visibleString = 0x0A;
  static const utf8String = 0x0C; // repurposed: also date-time in some meters
  static const bcd = 0x0D;
  static const int8 = 0x0F;
  static const int16 = 0x10;
  static const uint8 = 0x11;
  static const uint16 = 0x12;
  static const int64 = 0x14;
  static const uint64 = 0x15;
  static const enumeration = 0x16;
  static const float32 = 0x17;
  static const float64 = 0x18;
  static const dateTime = 0x19;
  static const date = 0x1A;
  static const time = 0x1B;
  static const dontCare = 0xFF;
}

// ── Sealed value hierarchy ────────────────────────────────────────────────────

sealed class DlmsData {
  const DlmsData();

  /// Human-readable string of the value (unit not included).
  String toDisplayString();
}

final class DlmsNull extends DlmsData {
  const DlmsNull();
  @override
  String toDisplayString() => 'null';
}

final class DlmsBoolean extends DlmsData {
  const DlmsBoolean(this.value);
  final bool value;
  @override
  String toDisplayString() => value ? 'true' : 'false';
}

final class DlmsInt extends DlmsData {
  const DlmsInt(this.value);
  final int value;
  @override
  String toDisplayString() => '$value';
}

final class DlmsDouble extends DlmsData {
  const DlmsDouble(this.value);
  final double value;
  @override
  String toDisplayString() => value.toStringAsFixed(3);
}

final class DlmsOctetString extends DlmsData {
  const DlmsOctetString(this.value);
  final Uint8List value;
  @override
  String toDisplayString() =>
      value.map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');
}

final class DlmsString extends DlmsData {
  const DlmsString(this.value);
  final String value;
  @override
  String toDisplayString() => value;
}

final class DlmsDateTime extends DlmsData {
  const DlmsDateTime(this.raw);
  final Uint8List raw; // 12 bytes per DLMS/COSEM spec

  DateTime? get dateTime {
    if (raw.length < 12) return null;
    try {
      final year = (raw[0] << 8) | raw[1];
      final month = raw[2];
      final day = raw[3];
      // raw[4] = day-of-week (0=Mon … 6=Sun, 0xFF=not specified)
      final hour = raw[5];
      final minute = raw[6];
      final second = raw[7];
      // raw[8] = hundredths
      // raw[9..10] = deviation (int16, minutes from UTC, 0x8000 = not specified)
      // raw[11] = clock status
      if (year == 0xFFFF || month == 0xFF || day == 0xFF) return null;
      return DateTime(year, month, day, hour, minute, second);
    } catch (_) {
      return null;
    }
  }

  @override
  String toDisplayString() =>
      dateTime?.toLocal().toString().substring(0, 19) ?? raw.toDisplayString();
}

final class DlmsArray extends DlmsData {
  const DlmsArray(this.elements);
  final List<DlmsData> elements;
  @override
  String toDisplayString() => '[${elements.map((e) => e.toDisplayString()).join(', ')}]';
}

final class DlmsStructure extends DlmsData {
  const DlmsStructure(this.elements);
  final List<DlmsData> elements;
  @override
  String toDisplayString() =>
      '{${elements.map((e) => e.toDisplayString()).join(', ')}}';
}

final class DlmsUnknown extends DlmsData {
  const DlmsUnknown({required this.tag, required this.raw});
  final int tag;
  final Uint8List raw;
  @override
  String toDisplayString() =>
      'unknown(0x${tag.toRadixString(16).padLeft(2, '0')}):${raw.toDisplayString()}';
}

// ── Decoder ───────────────────────────────────────────────────────────────────

abstract final class DlmsDecoder {
  /// Decodes a DLMS data value starting at [offset] in [data].
  /// Returns (decoded value, total bytes consumed including tag+length+value).
  static (DlmsData, int) decode(List<int> data, int offset) {
    if (offset >= data.length) return (const DlmsNull(), 0);

    final tag = data[offset];

    if (tag == DlmsTag.nullData) return (const DlmsNull(), 1);

    if (tag == DlmsTag.boolean) {
      return (DlmsBoolean(data[offset + 1] != 0), 2);
    }

    if (tag == DlmsTag.array || tag == DlmsTag.structure) {
      final count = data[offset + 1];
      var pos = offset + 2;
      final elements = <DlmsData>[];
      for (var i = 0; i < count; i++) {
        final (element, consumed) = decode(data, pos);
        elements.add(element);
        pos += consumed;
      }
      final result = tag == DlmsTag.array
          ? DlmsArray(elements)
          : DlmsStructure(elements);
      return (result, pos - offset);
    }

    if (tag == DlmsTag.int8) return (DlmsInt(_signed8(data[offset + 1])), 2);
    if (tag == DlmsTag.uint8 || tag == DlmsTag.enumeration) {
      return (DlmsInt(data[offset + 1]), 2);
    }

    if (tag == DlmsTag.int16) {
      return (DlmsInt(_signed16((data[offset + 1] << 8) | data[offset + 2])), 3);
    }
    if (tag == DlmsTag.uint16) {
      return (DlmsInt((data[offset + 1] << 8) | data[offset + 2]), 3);
    }

    if (tag == DlmsTag.int32) {
      final v = _signed32((data[offset + 1] << 24) |
          (data[offset + 2] << 16) |
          (data[offset + 3] << 8) |
          data[offset + 4]);
      return (DlmsInt(v), 5);
    }
    if (tag == DlmsTag.uint32) {
      final v = (data[offset + 1] << 24) |
          (data[offset + 2] << 16) |
          (data[offset + 3] << 8) |
          data[offset + 4];
      return (DlmsInt(v >>> 0), 5); // unsigned
    }

    if (tag == DlmsTag.int64 || tag == DlmsTag.uint64) {
      var v = 0;
      for (var i = 1; i <= 8; i++) {
        v = (v << 8) | data[offset + i];
      }
      return (DlmsInt(v), 9);
    }

    if (tag == DlmsTag.float32) {
      final bytes = Uint8List.fromList(data.sublist(offset + 1, offset + 5));
      final f = bytes.buffer.asByteData().getFloat32(0, Endian.big);
      return (DlmsDouble(f), 5);
    }
    if (tag == DlmsTag.float64) {
      final bytes = Uint8List.fromList(data.sublist(offset + 1, offset + 9));
      final f = bytes.buffer.asByteData().getFloat64(0, Endian.big);
      return (DlmsDouble(f), 9);
    }

    // Variable-length: read BER length
    final (len, lenBytes) = Ber.decodeLength(data, offset + 1);
    final valOffset = offset + 1 + lenBytes;
    final raw = Uint8List.fromList(data.sublist(valOffset, valOffset + len));
    final total = 1 + lenBytes + len;

    if (tag == DlmsTag.octetString) return (DlmsOctetString(raw), total);
    if (tag == DlmsTag.visibleString || tag == DlmsTag.utf8String) {
      return (DlmsString(utf8.decode(raw, allowMalformed: true)), total);
    }
    if (tag == DlmsTag.dateTime) return (DlmsDateTime(raw), total);

    return (DlmsUnknown(tag: tag, raw: raw), total);
  }

  static int _signed8(int v) => v > 0x7F ? v - 0x100 : v;
  static int _signed16(int v) => v > 0x7FFF ? v - 0x10000 : v;
  static int _signed32(int v) => v > 0x7FFFFFFF ? v - 0x100000000 : v;
}

extension on Uint8List {
  String toDisplayString() =>
      map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');
}
