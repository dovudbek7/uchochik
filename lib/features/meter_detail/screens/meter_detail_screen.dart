import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/enums/auth_level.dart';
import 'package:uchochik/domain/repositories/i_meter_repository.dart';

class MeterDetailScreen extends StatefulWidget {
  const MeterDetailScreen({super.key, required this.meterId});
  final int meterId;

  @override
  State<MeterDetailScreen> createState() => _MeterDetailScreenState();
}

class _MeterDetailScreenState extends State<MeterDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  Meter? _meter;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final meter = await getIt<IMeterRepository>().getById(widget.meterId);
    if (mounted) setState(() { _meter = meter; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }
    if (_meter == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Meter Detail')),
        body: const Center(
          child: Text('Meter not found', style: TextStyle(color: AppColors.onSurfaceMuted)),
        ),
      );
    }

    final m = _meter!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(m.serialNumber),
        bottom: TabBar(
          controller: _tabs,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.onSurfaceMuted,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: 'Readings'),
            Tab(text: 'Config'),
            Tab(text: 'Logs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _ReadingsTab(meter: m),
          _ConfigTab(meter: m),
          _LogsTab(meter: m),
        ],
      ),
    );
  }
}

// ── Info card widget ──────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: const TextStyle(
                    color: AppColors.onSurfaceMuted, fontSize: 13)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    color: AppColors.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

// ── Readings tab ──────────────────────────────────────────────────────────────

class _ReadingsTab extends StatelessWidget {
  const _ReadingsTab({required this.meter});
  final Meter meter;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _InfoRow(label: 'Account', value: meter.accountNumber),
        _InfoRow(label: 'Serial', value: meter.serialNumber),
        _InfoRow(label: 'Type', value: meter.meterType.displayName),
        _InfoRow(label: 'Last read',
            value: meter.lastReadAt?.toLocal().toString() ?? 'Never'),
        const Divider(height: 32),
        // Placeholder — Step 4 will add DLMS GET for OBIS registers
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: const Column(
            children: [
              Icon(Icons.cable_rounded,
                  color: AppColors.onSurfaceMuted, size: 40),
              SizedBox(height: 12),
              Text(
                'Connect to read registers',
                style: TextStyle(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              SizedBox(height: 6),
              Text(
                'Transport layer coming in Step 3.',
                style:
                    TextStyle(color: AppColors.onSurfaceMuted, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Config tab ────────────────────────────────────────────────────────────────

class _ConfigTab extends StatelessWidget {
  const _ConfigTab({required this.meter});
  final Meter meter;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _InfoRow(label: 'Logical Address',
            value: '0x${meter.logicalDeviceAddress.toRadixString(16).toUpperCase()}'),
        _InfoRow(label: 'Physical Address',
            value: '0x${meter.physicalAddress.toRadixString(16).toUpperCase()}'),
        _InfoRow(label: 'Client SAP',
            value: '0x${meter.clientAddress.toRadixString(16).toUpperCase()}'),
        _InfoRow(
            label: 'Auth Level', value: _authLabel(meter.authLevel)),
        _InfoRow(
            label: 'Manufacturer', value: meter.manufacturerId ?? '—'),
        _InfoRow(
            label: 'Firmware', value: meter.firmwareVersion ?? '—'),
        _InfoRow(
            label: 'Installed',
            value: meter.installedAt?.toLocal().toString() ?? '—'),
      ],
    );
  }

  String _authLabel(AuthLevel l) => switch (l) {
        AuthLevel.none => 'None (Public)',
        AuthLevel.low => 'Low (Password)',
        AuthLevel.high => 'High (GMAC/HLS)',
      };
}

// ── Logs tab ──────────────────────────────────────────────────────────────────

class _LogsTab extends StatelessWidget {
  const _LogsTab({required this.meter});
  final Meter meter;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Operation logs — Step 5',
        style: TextStyle(color: AppColors.onSurfaceMuted),
      ),
    );
  }
}
