import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/enums/auth_level.dart';
import 'package:uchochik/domain/repositories/i_meter_repository.dart';
import 'package:uchochik/domain/repositories/i_operation_log_repository.dart';
import 'package:uchochik/features/connection/bloc/connection_bloc.dart';
import 'package:uchochik/features/logs/screens/logs_screen.dart';
import 'package:uchochik/features/meter_reading/bloc/meter_reading_bloc.dart';
import 'package:uchochik/features/meter_reading/widgets/readings_table.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_remote_rounded),
            tooltip: 'Program meter',
            onPressed: () => context.push('/meter/${m.id}/program'),
          ),
        ],
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
    return BlocProvider(
      create: (_) => MeterReadingBloc(
        connectionBloc: getIt<ConnectionBloc>(),
        logRepository: getIt<IOperationLogRepository>(),
      ),
      child: _ReadingsTabBody(meter: meter),
    );
  }
}

class _ReadingsTabBody extends StatelessWidget {
  const _ReadingsTabBody({required this.meter});
  final Meter meter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeterReadingBloc, MeterReadingState>(
      builder: (context, state) {
        return Column(
          children: [
            // Header info strip
            Container(
              color: AppColors.surfaceContainer,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(meter.accountNumber,
                            style: const TextStyle(
                                color: AppColors.onSurface,
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                        Text(
                          state is MeterReadingSuccess
                              ? 'Read at ${_fmt(state.readAt)}'
                              : meter.lastReadAt != null
                                  ? 'Last read ${_fmt(meter.lastReadAt!)}'
                                  : 'Never read',
                          style: const TextStyle(
                              color: AppColors.onSurfaceMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  _ReadButton(meter: meter, state: state),
                ],
              ),
            ),
            // Body
            Expanded(child: _body(context, state)),
          ],
        );
      },
    );
  }

  Widget _body(BuildContext context, MeterReadingState state) {
    return switch (state) {
      MeterReadingIdle() => _emptyPlaceholder(),
      MeterReadingInProgress() => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              SizedBox(height: 16),
              Text('Reading meter…',
                  style: TextStyle(color: AppColors.onSurfaceMuted)),
            ],
          ),
        ),
      MeterReadingSuccess(readings: final r) => ReadingsTable(readings: r),
      MeterReadingFailure(error: final e) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded,
                    color: AppColors.error, size: 40),
                const SizedBox(height: 12),
                Text(e,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.onSurfaceMuted, fontSize: 13)),
              ],
            ),
          ),
        ),
    };
  }

  Widget _emptyPlaceholder() => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt_rounded, color: AppColors.onSurfaceMuted, size: 48),
            SizedBox(height: 12),
            Text('Tap Read to fetch registers',
                style: TextStyle(color: AppColors.onSurfaceMuted)),
          ],
        ),
      );

  String _fmt(DateTime dt) {
    final l = dt.toLocal();
    return '${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')} '
        '${l.day}/${l.month}/${l.year}';
  }
}

class _ReadButton extends StatelessWidget {
  const _ReadButton({required this.meter, required this.state});
  final Meter meter;
  final MeterReadingState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MeterReadingBloc>();
    final inProgress = state is MeterReadingInProgress;

    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: inProgress ? AppColors.error : AppColors.primary,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        textStyle:
            const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      onPressed: inProgress
          ? () => bloc.add(const ReadingCancelled())
          : () => bloc.add(ReadingStarted(meter: meter)),
      icon: Icon(inProgress ? Icons.stop_rounded : Icons.refresh_rounded,
          size: 18),
      label: Text(inProgress ? 'Stop' : 'Read'),
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
  Widget build(BuildContext context) => MeterLogsTab(meterId: meter.id);
}
