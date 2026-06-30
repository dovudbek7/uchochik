part of 'logs_bloc.dart';

sealed class LogsState {
  const LogsState();
}

final class LogsInitial extends LogsState {
  const LogsInitial();
}

final class LogsLoading extends LogsState {
  const LogsLoading();
}

final class LogsLoaded extends LogsState {
  const LogsLoaded({required this.logs, this.meterIdFilter});
  final List<OperationLog> logs;
  final int? meterIdFilter;
}

final class LogsError extends LogsState {
  const LogsError(this.message);
  final String message;
}
