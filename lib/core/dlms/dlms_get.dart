import 'dart:typed_data';

import 'package:uchochik/core/dlms/dlms_data.dart';
import 'package:uchochik/core/dlms/dlms_exception.dart';

// Data-access-result codes per IEC 62056-53 §7.5.6
const _accessResultDescriptions = {
  0x00: 'success',
  0x01: 'hardware-fault',
  0x02: 'temporary-failure',
  0x03: 'read-write-denied',
  0x04: 'object-undefined',
  0x09: 'object-class-inconsistent',
  0x0B: 'object-unavailable',
  0x0D: 'type-unmatched',
  0x0E: 'scope-of-access-violated',
  0x0F: 'data-block-unavailable',
  0x10: 'long-get-aborted',
  0x11: 'no-long-get-in-progress',
  0x12: 'long-set-aborted',
  0x13: 'no-long-set-in-progress',
  0x14: 'data-block-number-invalid',
  0x46: 'other-reason',
};

// Holds one decoded OBIS register reading.
class ObisReading {
  const ObisReading({
    required this.classId,
    required this.obis,
    required this.attributeId,
    required this.data,
    required this.readAt,
  });

  final int classId;
  final List<int> obis; // 6 bytes
  final int attributeId;
  final DlmsData data;
  final DateTime readAt;

  String get obisString =>
      obis.map((b) => '$b').join('.');

  @override
  String toString() => 'ObisReading($obisString = ${data.toDisplayString()})';
}

abstract final class DlmsGet {
  static var _invokeId = 0;

  static int _nextInvoke() {
    _invokeId = (_invokeId + 1) & 0x0F; // 4-bit invoke ID
    return (_invokeId & 0x0F) | 0x40; // invoke-id-and-priority: high priority
  }

  // ── GET-Request-Normal builder ────────────────────────────────────────────

  /// Builds a GET-Request-Normal APDU.
  static Uint8List buildRequest({
    required int classId,
    required List<int> obis, // 6 bytes
    int attributeId = 2, // 2 = value attribute
  }) {
    assert(obis.length == 6, 'OBIS code must be 6 bytes');

    return Uint8List.fromList([
      0xC0, // Get-Request tag
      0x01, // GET-Request-Normal choice
      _nextInvoke(), // invoke-id-and-priority
      // cosem-attribute-descriptor
      (classId >> 8) & 0xFF, classId & 0xFF, // class-id (uint16)
      ...obis, // instance-id (OBIS 6 bytes)
      attributeId, // attribute-id
      0x00, // access-selection: absent
    ]);
  }

  // ── GET-Response-Normal parser ────────────────────────────────────────────

  /// Parses a GET-Response-Normal APDU and returns the decoded [DlmsData].
  static DlmsData parseResponse(Uint8List bytes) {
    if (bytes.isEmpty) {
      throw const DlmsGetException('Empty GET-Response');
    }
    if (bytes[0] != 0xC4) {
      throw DlmsGetException(
        'Expected GET-Response (0xC4), got 0x${bytes[0].toRadixString(16)}',
      );
    }
    if (bytes[1] != 0x01) {
      throw DlmsGetException(
        'Only GET-Response-Normal supported; got choice ${bytes[1]}',
      );
    }

    // bytes[2] = invoke-id-and-priority (skip)
    // bytes[3] = result tag: 0x00 = Data, 0x01 = data-access-result (error)
    final resultTag = bytes[3];

    if (resultTag == 0x01) {
      // Error response
      final accessResult = bytes[4];
      final desc = _accessResultDescriptions[accessResult] ??
          'unknown-0x${accessResult.toRadixString(16)}';
      throw DlmsGetException(
        'GET failed: $desc',
        accessResult: accessResult,
      );
    }

    if (resultTag != 0x00) {
      throw DlmsGetException(
        'Unknown GET-Response result tag: 0x${resultTag.toRadixString(16)}',
      );
    }

    // bytes[4..] = data value (type tag + data)
    final (data, _) = DlmsDecoder.decode(bytes, 4);
    return data;
  }

  // ── Helper: build and parse in one shot ──────────────────────────────────

  /// Returns an [ObisReading] from a raw response, given the original request params.
  static ObisReading toReading({
    required int classId,
    required List<int> obis,
    required int attributeId,
    required Uint8List responseBytes,
  }) {
    final data = parseResponse(responseBytes);
    return ObisReading(
      classId: classId,
      obis: obis,
      attributeId: attributeId,
      data: data,
      readAt: DateTime.now(),
    );
  }
}
