import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchochik/core/dlms/dlms_get.dart';
import 'package:uchochik/core/dlms/dlms_session.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/entities/operation_log.dart';
import 'package:uchochik/domain/enums/operation_status.dart';
import 'package:uchochik/domain/repositories/i_operation_log_repository.dart';
import 'package:uchochik/features/connection/bloc/connection_bloc.dart';

part 'meter_reading_event.dart';
part 'meter_reading_state.dart';

class MeterReadingBloc extends Bloc<MeterReadingEvent, MeterReadingState> {
  MeterReadingBloc({
    required this.connectionBloc,
    required this.logRepository,
  }) : super(const MeterReadingIdle()) {
    on<ReadingStarted>(_onStarted);
    on<ReadingCancelled>(_onCancelled);
  }

  final ConnectionBloc connectionBloc;
  final IOperationLogRepository logRepository;
  DlmsSession? _session;

  Future<void> _onStarted(
    ReadingStarted event,
    Emitter<MeterReadingState> emit,
  ) async {
    emit(MeterReadingInProgress(meter: event.meter));

    final connState = connectionBloc.state;
    if (connState is! ConnectionActive) {
      emit(MeterReadingFailure(
        meter: event.meter,
        error: 'No active transport connection',
      ));
      return;
    }

    final transport = connState.transport;
    _session = DlmsSession(transport: transport, meter: event.meter);

    final start = DateTime.now();
    try {
      final descriptors = _descriptorsFor(event.meter);
      final readings = await _session!.readAll(descriptors);
      final durationMs = DateTime.now().difference(start).inMilliseconds;

      await _saveLog(
        meter: event.meter,
        status: OperationStatus.success,
        durationMs: durationMs,
      );

      if (!isClosed) {
        emit(MeterReadingSuccess(
          meter: event.meter,
          readings: readings,
          readAt: DateTime.now(),
        ));
      }
    } catch (e) {
      final durationMs = DateTime.now().difference(start).inMilliseconds;
      await _saveLog(
        meter: event.meter,
        status: OperationStatus.failure,
        durationMs: durationMs,
        errorMessage: e.toString(),
      );
      if (!isClosed) {
        emit(MeterReadingFailure(
          meter: event.meter,
          error: e.toString(),
        ));
      }
    } finally {
      await _session?.release();
      _session = null;
    }
  }

  Future<void> _onCancelled(
    ReadingCancelled event,
    Emitter<MeterReadingState> emit,
  ) async {
    await _session?.release();
    _session = null;
    emit(const MeterReadingIdle());
  }

  Future<void> _saveLog({
    required Meter meter,
    required OperationStatus status,
    required int durationMs,
    String? errorMessage,
  }) async {
    try {
      await logRepository.save(OperationLog(
        id: 0,
        meterId: meter.id,
        concentratorId: meter.concentratorId,
        operation: 'READ_REGISTERS',
        status: status,
        durationMs: durationMs,
        errorMessage: errorMessage,
        timestamp: DateTime.now(),
      ));
    } catch (_) {
      // Non-fatal
    }
  }

  List<ObisDescriptor> _descriptorsFor(Meter meter) {
    return ElectricityRegisters.standardReadout;
  }

  @override
  Future<void> close() async {
    await _session?.release();
    return super.close();
  }
}
