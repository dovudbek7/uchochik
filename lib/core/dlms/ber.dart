// BER (Basic Encoding Rules) helpers for DLMS/COSEM APDU construction/parsing.
abstract final class Ber {
  /// Encodes [length] as BER definite-length bytes.
  static List<int> length(int length) {
    if (length < 0x80) return [length];
    if (length < 0x100) return [0x81, length];
    return [0x82, (length >> 8) & 0xFF, length & 0xFF];
  }

  /// Decodes BER definite-length at [offset].
  /// Returns (decoded length, bytes consumed by the length field).
  static (int, int) decodeLength(List<int> data, int offset) {
    final first = data[offset];
    if (first < 0x80) return (first, 1);
    final numOctets = first & 0x7F;
    var len = 0;
    for (var i = 1; i <= numOctets; i++) {
      len = (len << 8) | data[offset + i];
    }
    return (len, 1 + numOctets);
  }

  /// Wraps [content] with [tag] and its BER length.
  static List<int> tlv(int tag, List<int> content) =>
      [tag, ...length(content.length), ...content];

  /// Wraps [content] with a 2-byte long-form tag and BER length.
  static List<int> tlv2(int tag1, int tag2, List<int> content) =>
      [tag1, tag2, ...length(content.length), ...content];
}
