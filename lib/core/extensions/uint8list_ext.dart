import 'dart:typed_data';

extension Uint8ListExtensions on Uint8List {
  /// Converts bytes to uppercase hex string, e.g. [0x7E, 0xA0] → "7EA0"
  String toHex({String separator = ''}) =>
      map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
          .join(separator);

  /// Splits bytes into chunks of [size] for chunked frame processing.
  List<Uint8List> chunk(int size) {
    final result = <Uint8List>[];
    for (var i = 0; i < length; i += size) {
      result.add(sublist(i, (i + size).clamp(0, length)));
    }
    return result;
  }
}

extension HexStringExtensions on String {
  /// Parses a hex string into a [Uint8List]. Input may contain spaces/colons.
  Uint8List hexToBytes() {
    final clean = replaceAll(RegExp(r'[\s:]'), '');
    assert(clean.length.isEven, 'Hex string must have even length');
    return Uint8List.fromList([
      for (var i = 0; i < clean.length; i += 2)
        int.parse(clean.substring(i, i + 2), radix: 16),
    ]);
  }

  /// True if string is a valid hex representation of [byteLength] bytes.
  bool isValidHexKey(int byteLength) {
    final clean = replaceAll(RegExp(r'[\s:]'), '');
    return clean.length == byteLength * 2 &&
        RegExp(r'^[0-9a-fA-F]+$').hasMatch(clean);
  }
}
