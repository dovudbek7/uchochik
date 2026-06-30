part of 'connection_bloc.dart';

sealed class ConnectionState {
  const ConnectionState();
}

/// No active connection, no pending connection.
final class ConnectionIdle extends ConnectionState {
  const ConnectionIdle();
}

/// Handshaking in progress (TCP connect or SNRM/UA for serial).
final class ConnectionConnecting extends ConnectionState {
  const ConnectionConnecting({required this.concentrator});
  final Concentrator concentrator;
}

/// Link layer connected — transport is ready for DLMS APDUs.
final class ConnectionActive extends ConnectionState {
  const ConnectionActive({
    required this.concentrator,
    required this.transport,
    required this.connectedAt,
  });
  final Concentrator concentrator;
  final ITransport transport;
  final DateTime connectedAt;
}

/// Connection attempt failed.
final class ConnectionFailed extends ConnectionState {
  const ConnectionFailed({
    required this.concentrator,
    required this.message,
  });
  final Concentrator concentrator;
  final String message;
}
