import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchochik/domain/entities/operation_log.dart';
import 'package:uchochik/domain/repositories/i_operation_log_repository.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  LogsBloc({required this.repository}) : super(const LogsInitial()) {
    on<LogsLoadRequested>(_onLoad);
    on<LogsMeterFilterSet>(_onFilterSet);
    on<LogsPurgeRequested>(_onPurge);
  }

  final IOperationLogRepository repository;

  int? _meterFilter;

  Future<void> _onLoad(
    LogsLoadRequested event,
    Emitter<LogsState> emit,
  ) async {
    emit(const LogsLoading());
    try {
      final logs = _meterFilter != null
          ? await repository.getByMeter(_meterFilter!)
          : await repository.getRecent(limit: 200);
      emit(LogsLoaded(logs: logs, meterIdFilter: _meterFilter));
    } catch (e) {
      emit(LogsError(e.toString()));
    }
  }

  Future<void> _onFilterSet(
    LogsMeterFilterSet event,
    Emitter<LogsState> emit,
  ) async {
    _meterFilter = event.meterId;
    add(const LogsLoadRequested());
  }

  Future<void> _onPurge(
    LogsPurgeRequested event,
    Emitter<LogsState> emit,
  ) async {
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    await repository.deleteOlderThan(cutoff);
    add(const LogsLoadRequested());
  }
}
