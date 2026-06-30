part of 'meter_reading_bloc.dart';

sealed class MeterReadingEvent {
  const MeterReadingEvent();
}

final class ReadingStarted extends MeterReadingEvent {
  const ReadingStarted({required this.meter});
  final Meter meter;
}

final class ReadingCancelled extends MeterReadingEvent {
  const ReadingCancelled();
}
