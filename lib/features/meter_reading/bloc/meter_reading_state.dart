part of 'meter_reading_bloc.dart';

sealed class MeterReadingState {
  const MeterReadingState();
}

final class MeterReadingIdle extends MeterReadingState {
  const MeterReadingIdle();
}

final class MeterReadingInProgress extends MeterReadingState {
  const MeterReadingInProgress({required this.meter});
  final Meter meter;
}

final class MeterReadingSuccess extends MeterReadingState {
  const MeterReadingSuccess({
    required this.meter,
    required this.readings,
    required this.readAt,
  });
  final Meter meter;
  final List<ObisReading> readings;
  final DateTime readAt;
}

final class MeterReadingFailure extends MeterReadingState {
  const MeterReadingFailure({
    required this.meter,
    required this.error,
  });
  final Meter meter;
  final String error;
}
