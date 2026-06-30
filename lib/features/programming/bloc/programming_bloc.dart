import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchochik/core/dlms/dlms_session.dart';
import 'package:uchochik/core/dlms/dlms_set.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/entities/operation_log.dart';
import 'package:uchochik/domain/enums/operation_status.dart';
import 'package:uchochik/domain/repositories/i_operation_log_repository.dart';
import 'package:uchochik/features/connection/bloc/connection_bloc.dart';

part 'programming_event.dart';
part 'programming_state.dart';

class ProgrammingBloc extends Bloc<ProgrammingEvent, ProgrammingState> {
  ProgrammingBloc({
    required this.connectionBloc,
    required this.logRepository,
  }) : super(const ProgrammingIdle()) {
    on<SetClockRequested>(_onSetClock);
    on<SetRelayRequested>(_onSetRelay);
  }

  final ConnectionBloc connectionBloc;
  final IOperationLogRepository logRepository;

  // ── Set Clock ────────────────────────────────────────────────────────────

  Future<void> _onSetClock(
    SetClockRequested event,
    Emitter<ProgrammingState> emit,
  ) async {
    await _runCommand(
      emit: emit,
      meter: event.meter,
      operation: 'SET_CLOCK',
      action: (session) async {
        final value = DlmsSet.encodeDateTime(event.dateTime);
        final req = DlmsSet.buildRequest(
          classId: 8, // Clock class
          obis: [0, 0, 1, 0, 0, 255],
          attributeId: 2,
          value: value,
        );
        final resp = await session.transport.request(req);
        DlmsSet.parseResponse(resp);
        return 'Clock set to ${event.dateTime.toLocal()}';
      },
    );
  }

  // ── Set Relay ────────────────────────────────────────────────────────────

  Future<void> _onSetRelay(
    SetRelayRequested event,
    Emitter<ProgrammingState> emit,
  ) async {
    await _runCommand(
      emit: emit,
      meter: event.meter,
      operation: event.connect ? 'RELAY_CONNECT' : 'RELAY_DISCONNECT',
      action: (session) async {
        // Data class (class 1), output-state OBIS 0.0.96.3.10.255
        final value = DlmsSet.encodeUint8(event.connect ? 1 : 0);
        final req = DlmsSet.buildRequest(
          classId: 1,
          obis: [0, 0, 96, 3, 10, 255],
          attributeId: 2,
          value: value,
        );
        final resp = await session.transport.request(req);
        DlmsSet.parseResponse(resp);
        return 'Relay ${event.connect ? 'connected' : 'disconnected'}';
      },
    );
  }

  // ── Generic command runner ───────────────────────────────────────────────

  Future<void> _runCommand({
    required Emitter<ProgrammingState> emit,
    required Meter meter,
    required String operation,
    required Future<String> Function(DlmsSession) action,
  }) async {
    emit(ProgrammingInProgress(operation: operation, meter: meter));

    final connState = connectionBloc.state;
    if (connState is! ConnectionActive) {
      emit(ProgrammingFailure(
        operation: operation,
        meter: meter,
        error: 'No active connection',
      ));
      return;
    }

    final session = DlmsSession(transport: connState.transport, meter: meter);
    final start = DateTime.now();
    try {
      await session.associate();
      final message = await action(session);
      final durationMs = DateTime.now().difference(start).inMilliseconds;
      await _saveLog(
        meter: meter,
        operation: operation,
        status: OperationStatus.success,
        durationMs: durationMs,
      );
      emit(ProgrammingSuccess(
        operation: operation,
        meter: meter,
        message: message,
      ));
    } catch (e) {
      final durationMs = DateTime.now().difference(start).inMilliseconds;
      await _saveLog(
        meter: meter,
        operation: operation,
        status: OperationStatus.failure,
        durationMs: durationMs,
        errorMessage: e.toString(),
      );
      emit(ProgrammingFailure(
        operation: operation,
        meter: meter,
        error: e.toString(),
      ));
    } finally {
      await session.release();
    }
  }

  Future<void> _saveLog({
    required Meter meter,
    required String operation,
    required OperationStatus status,
    required int durationMs,
    String? errorMessage,
  }) async {
    try {
      await logRepository.save(OperationLog(
        id: 0, // auto-increment
        meterId: meter.id,
        concentratorId: meter.concentratorId,
        operation: operation,
        status: status,
        durationMs: durationMs,
        errorMessage: errorMessage,
        timestamp: DateTime.now(),
      ));
    } catch (_) {
      // Non-fatal — log failure must not surface as command failure
    }
  }
}
