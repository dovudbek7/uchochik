import 'dart:typed_data';

enum TransportStatus { disconnected, connecting, connected, error }

abstract interface class ITransport {
  bool get isConnected;
  Stream<TransportStatus> get statusStream;

  /// Link-layer connect.
  /// TCP: opens socket.
  /// Serial: opens port + SNRM/UA handshake.
  Future<void> connect();

  Future<void> disconnect();

  /// Send [apdu] and receive response APDU.
  /// TCP: wraps/unwraps IEC 62056-47 header.
  /// Serial: wraps/unwraps HDLC I-frame.
  Future<Uint8List> request(Uint8List apdu, {Duration timeout});
}
