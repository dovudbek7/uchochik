import 'package:flutter/material.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/dlms/dlms_get.dart';
import 'package:uchochik/core/dlms/dlms_session.dart';

class ReadingsTable extends StatelessWidget {
  const ReadingsTable({super.key, required this.readings});

  final List<ObisReading> readings;

  @override
  Widget build(BuildContext context) {
    if (readings.isEmpty) {
      return const Center(
        child: Text(
          'No readings returned',
          style: TextStyle(color: AppColors.onSurfaceMuted),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: readings.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: AppColors.border),
      itemBuilder: (context, i) => _ReadingRow(reading: readings[i]),
    );
  }
}

class _ReadingRow extends StatelessWidget {
  const _ReadingRow({required this.reading});
  final ObisReading reading;

  @override
  Widget build(BuildContext context) {
    final label = _labelFor(reading);
    final unit = _unitFor(reading);
    final value = reading.data.toDisplayString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // OBIS code chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              reading.obisString,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: AppColors.onSurfaceMuted,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Label + value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.onSurfaceMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: AppColors.onSurface,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (unit != null) ...[
                      const SizedBox(width: 4),
                      Text(
                        unit,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _labelFor(ObisReading r) {
    final match = ElectricityRegisters.standardReadout.where(
      (d) => _obisMatch(d.obis, r.obis),
    );
    return match.isNotEmpty ? match.first.label : 'Register';
  }

  String? _unitFor(ObisReading r) {
    final match = ElectricityRegisters.standardReadout.where(
      (d) => _obisMatch(d.obis, r.obis),
    );
    return match.isNotEmpty ? match.first.unit : null;
  }

  bool _obisMatch(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
