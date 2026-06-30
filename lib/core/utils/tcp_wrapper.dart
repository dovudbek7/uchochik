import 'dart:typed_data';

// IEC 62056-47 TCP/UDP transport wrapper.
// Header: version(2) + length(2) where version = 0x0001.
abstract final class TcpWrapper {
  static const _version = [0x00, 0x01];

  static Uint8List wrap(Uint8List apdu) {
    final len = apdu.length;
    return Uint8List.fromList([
      ..._version,
      (len >> 8) & 0xFF,
      len & 0xFF,
      ...apdu,
    ]);
  }

  /// Returns the APDU if the buffer contains a complete frame, null otherwise.
  /// Advances [buffer] past the consumed frame.
  static Uint8List? tryParse(List<int> buffer) {
    if (buffer.length < 4) return null;
    if (buffer[0] != 0x00 || buffer[1] != 0x01) {
      throw const FormatException('Invalid IEC 62056-47 version bytes');
    }
    final apduLen = (buffer[2] << 8) | buffer[3];
    if (buffer.length < 4 + apduLen) return null;
    final apdu = Uint8List.fromList(buffer.sublist(4, 4 + apduLen));
    buffer.removeRange(0, 4 + apduLen);
    return apdu;
  }
}
