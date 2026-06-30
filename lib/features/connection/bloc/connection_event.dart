part of 'connection_bloc.dart';

sealed class ConnectionEvent {
  const ConnectionEvent();
}

final class ConnectRequested extends ConnectionEvent {
  const ConnectRequested({required this.concentrator});
  final Concentrator concentrator;
}

final class DisconnectRequested extends ConnectionEvent {}
