enum MeterType {
  electricity,
  gas,
  water;

  String get displayName => switch (this) {
        MeterType.electricity => 'Electricity',
        MeterType.gas => 'Gas',
        MeterType.water => 'Water',
      };
}
