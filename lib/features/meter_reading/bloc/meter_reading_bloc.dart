import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchochik/core/dlms/dlms_get.dart';
import 'package:uchochik/core/dlms/dlms_session.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/features/connection/bloc/connection_bloc.dart';

part 'meter_reading_event.dart';
part 'meter_reading_state.dart';

class MeterReadingBloc extends Bloc<MeterReadingEvent, MeterReadingState> {
  MeterReadingBloc({required this.connectionBloc})
      : super(const MeterReadingIdle()) {
    on<ReadingStarted>(_onStarted);
    on<ReadingCancelled>(_onCancelled);
  }

  final ConnectionBloc connectionBloc;
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

    try {
      final descriptors = _descriptorsFor(event.meter);
      final readings = await _session!.readAll(descriptors);

      if (!isClosed) {
        emit(MeterReadingSuccess(
          meter: event.meter,
          readings: readings,
          readAt: DateTime.now(),
        ));
      }
    } catch (e) {
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

  List<ObisDescriptor> _descriptorsFor(Meter meter) {
    // Currently only electricity — extend here for gas/water registers
    return ElectricityRegisters.standardReadout;
  }

  @override
  Future<void> close() async {
    await _session?.release();
    return super.close();
  }
}
