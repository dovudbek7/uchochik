// CRC-16/CCITT reflected (polynomial 0x8408).
// Used for HDLC HCS (header check sequence) and FCS (frame check sequence)
// per IEC 62056-46.
abstract final class Crc16 {
  static const _poly = 0x8408;

  static int compute(List<int> data) {
    var crc = 0xFFFF;
    for (final byte in data) {
      crc ^= byte & 0xFF;
      for (var i = 0; i < 8; i++) {
        crc = (crc & 1) == 1 ? (crc >> 1) ^ _poly : crc >> 1;
      }
    }
    return (~crc) & 0xFFFF;
  }

  /// Returns CRC as little-endian bytes [low, high].
  static List<int> bytes(List<int> data) {
    final c = compute(data);
    return [c & 0xFF, (c >> 8) & 0xFF];
  }

  static bool verify(List<int> data, List<int> receivedCrc) {
    return compute(data) == (receivedCrc[0] | (receivedCrc[1] << 8));
  }
}
