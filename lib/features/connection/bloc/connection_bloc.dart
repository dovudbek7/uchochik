import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchochik/domain/entities/concentrator.dart';
import 'package:uchochik/features/connection/transport/i_transport.dart';
import 'package:uchochik/features/connection/transport/transport_factory.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  ConnectionBloc() : super(const ConnectionIdle()) {
    on<ConnectRequested>(_onConnect);
    on<DisconnectRequested>(_onDisconnect);
  }

  StreamSubscription<TransportStatus>? _statusSub;

  @override
  Future<void> close() async {
    await _statusSub?.cancel();
    if (state is ConnectionActive) {
      await (state as ConnectionActive).transport.disconnect();
    }
    return super.close();
  }

  Future<void> _onConnect(
    ConnectRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    emit(ConnectionConnecting(concentrator: event.concentrator));
    try {
      final transport = TransportFactory.create(event.concentrator);

      // Forward transport status changes into the bloc
      _statusSub = transport.statusStream.listen((status) {
        if (status == TransportStatus.disconnected && !isClosed) {
          add(DisconnectRequested());
        }
      });

      await transport.connect();
      emit(ConnectionActive(
        concentrator: event.concentrator,
        transport: transport,
        connectedAt: DateTime.now(),
      ));
    } catch (e) {
      emit(ConnectionFailed(
        concentrator: event.concentrator,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDisconnect(
    DisconnectRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    await _statusSub?.cancel();
    _statusSub = null;

    if (state is ConnectionActive) {
      try {
        await (state as ConnectionActive).transport.disconnect();
      } catch (_) {}
    }
    emit(const ConnectionIdle());
  }
}
