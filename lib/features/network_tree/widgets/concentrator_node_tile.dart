import 'package:flutter/material.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/enums/communication_type.dart';
import 'package:uchochik/features/network_tree/bloc/network_tree_bloc.dart';
import 'package:uchochik/features/network_tree/widgets/meter_node_tile.dart';

class ConcentratorNodeTile extends StatelessWidget {
  const ConcentratorNodeTile({
    super.key,
    required this.node,
    required this.onToggle,
    required this.onAddMeter,
    required this.onDeleteConcentrator,
    required this.onMeterTap,
    required this.onDeleteMeter,
  });

  final ConcentratorNode node;
  final VoidCallback onToggle;
  final VoidCallback onAddMeter;
  final VoidCallback onDeleteConcentrator;
  final void Function(Meter meter) onMeterTap;
  final void Function(int meterId) onDeleteMeter;

  @override
  Widget build(BuildContext context) {
    final c = node.concentrator;
    final isTcp = c.communicationType == CommunicationType.tcpIp;
    final subtitle = isTcp
        ? '${c.ipAddress ?? '—'}:${c.port ?? '—'}'
        : c.serialPortDevice ?? '—';

    return Column(
      children: [
        // ── Header ────────────────────────────────────────────────────────────
        GestureDetector(
          onTap: onToggle,
          child: Container(
            margin: const EdgeInsets.only(left: 24, right: 12, top: 4, bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(
                  isTcp ? Icons.router_rounded : Icons.usb_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.name,
                        style: const TextStyle(
                          color: AppColors.onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppColors.onSurfaceMuted,
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                _MeterCountBadge(count: node.meters.length),
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
                const SizedBox(width: 4),
                _ConcentratorMenu(
                  onAddMeter: onAddMeter,
                  onDelete: onDeleteConcentrator,
                ),
              ],
            ),
          ),
        ),
        // ── Children ─────────────────────────────────────────────────────────
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: node.isExpanded
              ? Column(
                  children: [
                    ...node.meters.map(
                      (m) => MeterNodeTile(
                        meter: m,
                        onTap: () => onMeterTap(m),
                        onDelete: () => onDeleteMeter(m.id),
                      ),
                    ),
                    _AddMeterButton(onTap: onAddMeter),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _MeterCountBadge extends StatelessWidget {
  const _MeterCountBadge({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: AppColors.onSurfaceMuted,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ConcentratorMenu extends StatelessWidget {
  const _ConcentratorMenu({required this.onAddMeter, required this.onDelete});
  final VoidCallback onAddMeter;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded,
          color: AppColors.onSurfaceMuted, size: 18),
      color: AppColors.surfaceContainerHigh,
      itemBuilder: (_) => [
        const PopupMenuItem(value: 'add', child: Text('Add Meter')),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete', style: TextStyle(color: AppColors.error)),
        ),
      ],
      onSelected: (v) {
        if (v == 'add') onAddMeter();
        if (v == 'delete') onDelete();
      },
    );
  }
}

class _AddMeterButton extends StatelessWidget {
  const _AddMeterButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 48, right: 12, top: 4, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border, style: BorderStyle.solid),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_rounded, color: AppColors.primary, size: 16),
            SizedBox(width: 6),
            Text(
              'Add Meter',
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
