part of 'logs_bloc.dart';

sealed class LogsEvent {
  const LogsEvent();
}

final class LogsLoadRequested extends LogsEvent {
  const LogsLoadRequested();
}

final class LogsMeterFilterSet extends LogsEvent {
  const LogsMeterFilterSet(this.meterId);
  final int? meterId;
}

final class LogsPurgeRequested extends LogsEvent {
  const LogsPurgeRequested();
}
