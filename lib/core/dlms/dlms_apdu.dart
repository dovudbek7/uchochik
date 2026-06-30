import 'dart:convert';
import 'dart:typed_data';

import 'package:uchochik/core/dlms/ber.dart';
import 'package:uchochik/core/dlms/dlms_exception.dart';
import 'package:uchochik/domain/enums/auth_level.dart';

// Application context OID for LN referencing, no ciphering:
// { 2 16 756 5 8 1 1 } = 60 85 74 05 08 01 01
const _oidAppContextLnNoCipher = [0x60, 0x85, 0x74, 0x05, 0x08, 0x01, 0x01];

// Mechanism name OID for low-level-security:
// { 2 16 756 5 8 2 1 } = 60 85 74 05 08 02 01
const _oidMechanismLowLevel = [0x60, 0x85, 0x74, 0x05, 0x08, 0x02, 0x01];

// ── AARQ builder ─────────────────────────────────────────────────────────────

abstract final class DlmsApdu {
  /// Builds an AARQ APDU (APPLICATION 0, tag 0x60).
  /// Supports no-auth and low-level (password) authentication.
  static Uint8List buildAarq({
    AuthLevel authLevel = AuthLevel.none,
    String? password,
    int maxPduSize = 0xFFFF,
  }) {
    final parts = <int>[];

    // [1] application-context-name
    parts.addAll(Ber.tlv(0xA1, [
      ...Ber.tlv(0x06, _oidAppContextLnNoCipher),
    ]));

    // Authentication fields (low-level only)
    if (authLevel == AuthLevel.low && password != null && password.isNotEmpty) {
      // [10] ACSE-requirements BIT STRING {authentication} = 07 80
      parts.addAll([0x8A, 0x02, 0x07, 0x80]);
      // [11] mechanism-name
      parts.addAll([0x8B, _oidMechanismLowLevel.length, ..._oidMechanismLowLevel]);
      // [12] calling-authentication-value [0] IMPLICIT OCTET STRING
      final pwBytes = utf8.encode(password);
      final authVal = Ber.tlv(0x80, pwBytes);
      parts.addAll(Ber.tlv(0xAC, authVal));
    }

    // [30] user-information  (xDLMS InitiateRequest wrapped in OCTET STRING)
    final initiate = _buildInitiateRequest(maxPduSize);
    final userInfo = Ber.tlv(0x04, initiate);
    parts.addAll(Ber.tlv(0xBE, userInfo));

    return Uint8List.fromList(Ber.tlv(0x60, parts));
  }

  // xDLMS InitiateRequest per IEC 62056-53 §9.4.2.2
  // proposed-conformance: APPLICATION 31 IMPLICIT BIT STRING
  // Value 0x001F04: read, write, unconf-write, block-transfer-get,
  //                 block-transfer-set, action, multiple-references
  static List<int> _buildInitiateRequest(int maxPduSize) => [
        0x01, // CHOICE: xDLMS-Initiate.request
        0x00, // dedicated-key: absent
        0x00, // response-allowed: TRUE
        0x00, // proposed-quality-of-service
        0x06, // proposed-dlms-version: 6
        0x5F, 0x1F, 0x04, 0x00, 0x00, 0x7E, 0x1F, // proposed-conformance
        (maxPduSize >> 8) & 0xFF, maxPduSize & 0xFF, // max pdu size
      ];

  // ── AARE parser ──────────────────────────────────────────────────────────

  static AareResult parseAare(Uint8List bytes) {
    if (bytes.isEmpty || bytes[0] != 0x61) {
      throw DlmsAssociationException(
        'Expected AARE (0x61), got 0x${bytes[0].toRadixString(16)}',
      );
    }

    var offset = 1;
    final (totalLen, lenBytes) = Ber.decodeLength(bytes, offset);
    offset += lenBytes;
    final end = offset + totalLen;

    int? result;
    int? diagnostic;

    while (offset < end) {
      final tag = bytes[offset++];
      final (len, lb) = Ber.decodeLength(bytes, offset);
      offset += lb;

      switch (tag) {
        case 0xA2: // [2] result INTEGER
          // 02 01 [value]
          if (bytes[offset] == 0x02 && bytes[offset + 1] == 0x01) {
            result = bytes[offset + 2];
          }
        case 0xA3: // [3] result-source-diagnostic
          // A1 03 02 01 [value]
          if (offset + 4 < bytes.length && bytes[offset + 2] == 0x02) {
            diagnostic = bytes[offset + 4];
          }
        // Skip all other tags
      }
      offset += len;
    }

    if (result == null) {
      throw const DlmsAssociationException('AARE missing result field');
    }
    if (result != 0) {
      throw DlmsAssociationException(
        'Association rejected: result=$result, diagnostic=$diagnostic',
        resultCode: result,
      );
    }

    return AareResult(result: result, diagnostic: diagnostic ?? 0);
  }

  // ── RLRQ (Release Request) ────────────────────────────────────────────────

  static Uint8List buildRlrq() =>
      Uint8List.fromList([0x62, 0x00]); // RLRQ with no content
}

class AareResult {
  const AareResult({required this.result, required this.diagnostic});
  final int result;
  final int diagnostic;
  bool get isSuccess => result == 0;
}
