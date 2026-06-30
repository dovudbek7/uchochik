part of 'programming_bloc.dart';

sealed class ProgrammingEvent {
  const ProgrammingEvent();
}

final class SetClockRequested extends ProgrammingEvent {
  const SetClockRequested({required this.meter, required this.dateTime});
  final Meter meter;
  final DateTime dateTime;
}

final class SetRelayRequested extends ProgrammingEvent {
  const SetRelayRequested({required this.meter, required this.connect});
  final Meter meter;
  final bool connect;
}

final class ReadLoadProfileRequested extends ProgrammingEvent {
  const ReadLoadProfileRequested({
    required this.meter,
    required this.obis,
    this.label = 'Load Profile',
  });
  final Meter meter;
  final List<int> obis;
  final String label;
}
