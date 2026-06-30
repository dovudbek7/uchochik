import 'dart:typed_data';

import 'package:uchochik/core/dlms/dlms_data.dart';
import 'package:uchochik/core/dlms/dlms_exception.dart';

// Profile Generic (class 7) attribute indices
// attr 1: logical-name  attr 2: buffer  attr 3: capture-objects
// attr 4: capture-period  attr 5: sort-method  attr 6: entries-in-use
// attr 7: profile-entries

/// Standard load profile OBIS: 1.0.99.1.0.255
const obisLoadProfile = [1, 0, 99, 1, 0, 255];

/// Standard daily profile OBIS: 1.0.99.2.0.255
const obisDailyProfile = [1, 0, 99, 2, 0, 255];

/// One captured row in a profile buffer.
class ProfileEntry {
  const ProfileEntry({required this.columns});
  final List<DlmsData> columns;

  @override
  String toString() =>
      columns.map((c) => c.toDisplayString()).join(' | ');
}

abstract final class DlmsProfile {
  static var _invokeId = 0;

  static int _nextInvoke() {
    _invokeId = (_invokeId + 1) & 0x0F;
    return (_invokeId & 0x0F) | 0x40;
  }

  // ── GET buffer (attr 2) — last N entries via range descriptor ────────────

  /// Builds GET-Request-Normal for Profile Generic buffer (last [entries] rows).
  /// Uses selective access by entry-descriptor to limit data transfer.
  static Uint8List buildGetBuffer({
    required List<int> obis,
    int entries = 96, // last 96 periods (e.g. 96×15min = 24h)
  }) {
    // selective-access: entry-descriptor (choice 2)
    // [2] SEQUENCE { from_entry (1-based), to_entry (0=last), from_col, to_col }
    final selectiveAccess = [
      0x01, // access-selection present
      0x02, // entry-descriptor
      0x02, // STRUCTURE tag
      0x04, // 4 elements
      DlmsTag.uint32, 0x00, 0x00, 0x00, 0x01, // from_entry = 1
      DlmsTag.uint32, 0x00, 0x00, 0x00, 0x00, // to_entry   = 0 (last)
      DlmsTag.uint16, 0x00, 0x01, // from_col = 1
      DlmsTag.uint16, 0x00, 0x00, // to_col   = 0 (all)
    ];

    return Uint8List.fromList([
      0xC0, 0x01, _nextInvoke(),
      (7 >> 8) & 0xFF, 7 & 0xFF, // class-id = 7
      ...obis, // instance-id
      0x02, // attribute-id = 2 (buffer)
      ...selectiveAccess,
    ]);
  }

  /// Builds GET-Request-Normal for entries-in-use (attr 7).
  static Uint8List buildGetEntriesInUse({required List<int> obis}) =>
      Uint8List.fromList([
        0xC0, 0x01, _nextInvoke(),
        0x00, 0x07, // class-id = 7
        ...obis,
        0x07, // attribute-id = 7 (profile-entries)
        0x00, // no selective access
      ]);

  // ── Response parser ───────────────────────────────────────────────────────

  /// Parses GET-Response-Normal for a Profile Generic buffer (attr 2).
  /// Returns a list of [ProfileEntry] rows. Each row is a structure of columns.
  static List<ProfileEntry> parseBuffer(Uint8List bytes) {
    if (bytes.isEmpty || bytes[0] != 0xC4 || bytes[1] != 0x01) {
      throw DlmsGetException(
        'Expected GET-Response-Normal for profile; got tag 0x${bytes.isNotEmpty ? bytes[0].toRadixString(16) : "empty"}',
      );
    }
    final resultTag = bytes[3];
    if (resultTag == 0x01) {
      final accessResult = bytes[4];
      throw DlmsGetException(
        'Profile GET failed: access-result=0x${accessResult.toRadixString(16)}',
        accessResult: accessResult,
      );
    }

    // bytes[4..] = array of structures
    final (data, _) = DlmsDecoder.decode(bytes, 4);
    if (data is! DlmsArray) {
      throw DlmsGetException(
        'Profile buffer expected ARRAY, got ${data.runtimeType}',
      );
    }

    final entries = <ProfileEntry>[];
    for (final element in data.elements) {
      if (element is DlmsStructure) {
        entries.add(ProfileEntry(columns: element.elements));
      }
    }
    return entries;
  }
}
