part of 'programming_bloc.dart';

sealed class ProgrammingState {
  const ProgrammingState();
}

final class ProgrammingIdle extends ProgrammingState {
  const ProgrammingIdle();
}

final class ProgrammingInProgress extends ProgrammingState {
  const ProgrammingInProgress({
    required this.operation,
    required this.meter,
  });
  final String operation;
  final Meter meter;
}

final class ProgrammingSuccess extends ProgrammingState {
  const ProgrammingSuccess({
    required this.operation,
    required this.meter,
    required this.message,
  });
  final String operation;
  final Meter meter;
  final String message;
}

final class ProgrammingFailure extends ProgrammingState {
  const ProgrammingFailure({
    required this.operation,
    required this.meter,
    required this.error,
  });
  final String operation;
  final Meter meter;
  final String error;
}
