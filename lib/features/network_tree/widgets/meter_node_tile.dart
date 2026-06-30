import 'package:flutter/material.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/enums/meter_type.dart';

class MeterNodeTile extends StatelessWidget {
  const MeterNodeTile({
    super.key,
    required this.meter,
    required this.onTap,
    required this.onDelete,
  });

  final Meter meter;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 48, right: 12, top: 4, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            _MeterTypeIcon(meterType: meter.meterType),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meter.serialNumber,
                    style: const TextStyle(
                      color: AppColors.onSurface,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ACC: ${meter.accountNumber}',
                    style: const TextStyle(
                      color: AppColors.onSurfaceMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (meter.lastReadAt != null)
              _LastReadChip(lastReadAt: meter.lastReadAt!),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDelete,
              child: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.onSurfaceMuted,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeterTypeIcon extends StatelessWidget {
  const _MeterTypeIcon({required this.meterType});
  final MeterType meterType;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (meterType) {
      MeterType.electricity => (Icons.electric_bolt_rounded, AppColors.electricity),
      MeterType.gas => (Icons.local_fire_department_rounded, AppColors.gas),
      MeterType.water => (Icons.water_drop_rounded, AppColors.water),
    };
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }
}

class _LastReadChip extends StatelessWidget {
  const _LastReadChip({required this.lastReadAt});
  final DateTime lastReadAt;

  String get _label {
    final diff = DateTime.now().difference(lastReadAt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.online.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        _label,
        style: const TextStyle(
          color: AppColors.online,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
