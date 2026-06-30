/// Maps to DLMS/COSEM authentication levels per IEC 62056-62.
/// none=0 (no authentication), low=1 (password), high=2 (GMAC/HLS).
enum AuthLevel {
  none,
  low,
  high;

  int get dlmsValue => index; // 0, 1, 2

  String get displayName => switch (this) {
        AuthLevel.none => 'None (Public)',
        AuthLevel.low => 'Low (Password)',
        AuthLevel.high => 'High (GMAC/HLS)',
      };
}
