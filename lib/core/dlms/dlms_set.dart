import 'dart:typed_data';

import 'package:uchochik/core/dlms/dlms_data.dart';
import 'package:uchochik/core/dlms/dlms_exception.dart';

// Data-access-result codes (same as GET, reused)
const _accessResultDescriptions = {
  0x00: 'success',
  0x01: 'hardware-fault',
  0x03: 'read-write-denied',
  0x04: 'object-undefined',
  0x0D: 'type-unmatched',
  0x0E: 'scope-of-access-violated',
  0x46: 'other-reason',
};

abstract final class DlmsSet {
  static var _invokeId = 0;

  static int _nextInvoke() {
    _invokeId = (_invokeId + 1) & 0x0F;
    return (_invokeId & 0x0F) | 0x40;
  }

  // ── SET-Request-Normal ────────────────────────────────────────────────────

  /// Builds a SET-Request-Normal APDU.
  static Uint8List buildRequest({
    required int classId,
    required List<int> obis,
    int attributeId = 2,
    required List<int> value, // already-encoded DLMS data bytes (tag + data)
  }) {
    assert(obis.length == 6);
    return Uint8List.fromList([
      0xC1, // Set-Request tag
      0x01, // SET-Request-Normal choice
      _nextInvoke(),
      (classId >> 8) & 0xFF, classId & 0xFF,
      ...obis,
      attributeId,
      0x00, // access-selection: absent
      ...value,
    ]);
  }

  // ── SET-Response-Normal parser ────────────────────────────────────────────

  static void parseResponse(Uint8List bytes) {
    if (bytes.isEmpty || bytes[0] != 0xC5) {
      throw DlmsSetException(
        'Expected SET-Response (0xC5), got 0x${bytes[0].toRadixString(16)}',
      );
    }
    if (bytes[1] != 0x01) {
      throw DlmsSetException('Only SET-Response-Normal supported');
    }
    // bytes[2] = invoke-id, bytes[3] = result
    final result = bytes[3];
    if (result != 0x00) {
      final desc = _accessResultDescriptions[result] ??
          'unknown-0x${result.toRadixString(16)}';
      throw DlmsSetException('SET failed: $desc', accessResult: result);
    }
  }

  // ── Value encoders ────────────────────────────────────────────────────────

  /// Encodes a DLMS octet-string (tag 0x09 + BER length + bytes).
  static List<int> encodeOctetString(List<int> bytes) => [
        DlmsTag.octetString,
        bytes.length,
        ...bytes,
      ];

  /// Encodes a DLMS visible-string (tag 0x0A + BER length + ASCII bytes).
  static List<int> encodeVisibleString(String s) {
    final bytes = s.codeUnits;
    return [DlmsTag.visibleString, bytes.length, ...bytes];
  }

  /// Encodes a DLMS uint8 (tag 0x11 + byte).
  static List<int> encodeUint8(int v) => [DlmsTag.uint8, v & 0xFF];

  /// Encodes a DLMS int32 (tag 0x05 + 4 bytes big-endian).
  static List<int> encodeInt32(int v) => [
        DlmsTag.int32,
        (v >> 24) & 0xFF,
        (v >> 16) & 0xFF,
        (v >> 8) & 0xFF,
        v & 0xFF,
      ];

  /// Encodes a DLMS date-time (tag 0x19 + 12 raw bytes).
  static List<int> encodeDateTime(DateTime dt) {
    final year = dt.year;
    return [
      DlmsTag.dateTime,
      (year >> 8) & 0xFF, year & 0xFF, // year (uint16)
      dt.month, // month
      dt.day, // day
      0xFF, // day-of-week: not specified
      dt.hour,
      dt.minute,
      dt.second,
      0x00, // hundredths
      0x80, 0x00, // deviation: not specified
      0x00, // clock status: OK
    ];
  }
}

class DlmsSetException extends DlmsException {
  const DlmsSetException(super.message, {this.accessResult});
  final int? accessResult;
}
