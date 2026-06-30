import 'package:flutter/material.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/features/network_tree/bloc/network_tree_bloc.dart';
import 'package:uchochik/features/network_tree/widgets/concentrator_node_tile.dart';

class GroupNodeTile extends StatelessWidget {
  const GroupNodeTile({
    super.key,
    required this.node,
    required this.onToggle,
    required this.onToggleConcentrator,
    required this.onAddConcentrator,
    required this.onAddMeter,
    required this.onDeleteConcentrator,
    required this.onMeterTap,
    required this.onDeleteMeter,
  });

  final GroupNode node;
  final VoidCallback onToggle;
  final void Function(int concentratorId) onToggleConcentrator;
  final VoidCallback onAddConcentrator;
  final void Function(int concentratorId) onAddMeter;
  final void Function(int concentratorId) onDeleteConcentrator;
  final void Function(Meter meter) onMeterTap;
  final void Function(int meterId) onDeleteMeter;

  int get _totalMeters =>
      node.concentrators.fold(0, (sum, c) => sum + c.meters.length);

  @override
  Widget build(BuildContext context) {
    final label = node.group?.name ?? 'Ungrouped';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Group header ──────────────────────────────────────────────────────
        GestureDetector(
          onTap: onToggle,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.folder_rounded,
                    color: AppColors.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.onSurface,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                Text(
                  '${node.concentrators.length} dev · $_totalMeters meters',
                  style: const TextStyle(
                    color: AppColors.onSurfaceMuted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: node.isExpanded ? 0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.onSurfaceMuted,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        // ── Concentrators ─────────────────────────────────────────────────────
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          child: node.isExpanded
              ? Column(
                  children: [
                    ...node.concentrators.map(
                      (c) => ConcentratorNodeTile(
                        node: c,
                        onToggle: () =>
                            onToggleConcentrator(c.concentrator.id),
                        onAddMeter: () => onAddMeter(c.concentrator.id),
                        onDeleteConcentrator: () =>
                            onDeleteConcentrator(c.concentrator.id),
                        onMeterTap: onMeterTap,
                        onDeleteMeter: onDeleteMeter,
                      ),
                    ),
                    _AddConcentratorButton(onTap: onAddConcentrator),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _AddConcentratorButton extends StatelessWidget {
  const _AddConcentratorButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 12, top: 4, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_rounded, color: AppColors.primary, size: 16),
            SizedBox(width: 6),
            Text(
              'Add Concentrator',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
