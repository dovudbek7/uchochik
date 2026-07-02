import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/core/dlms/dlms_profile.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/repositories/i_operation_log_repository.dart';
import 'package:uchochik/features/connection/bloc/connection_bloc.dart';
import 'package:uchochik/features/programming/bloc/programming_bloc.dart';

class ProgrammingScreen extends StatelessWidget {
  const ProgrammingScreen({super.key, required this.meter});
  final Meter meter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProgrammingBloc(
        connectionBloc: getIt<ConnectionBloc>(),
        logRepository: getIt<IOperationLogRepository>(),
      ),
      child: _ProgrammingBody(meter: meter),
    );
  }
}

class _ProgrammingBody extends StatelessWidget {
  const _ProgrammingBody({required this.meter});
  final Meter meter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text('Program — ${meter.serialNumber}'),
      ),
      body: BlocConsumer<ProgrammingBloc, ProgrammingState>(
        listener: (context, state) {
          if (state is ProgrammingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.primary,
              ),
            );
          }
          if (state is ProgrammingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final busyState =
              state is ProgrammingInProgress ? state : null;
          final busy = busyState != null;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (busy) ...[
                const LinearProgressIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surfaceContainer,
                ),
                const SizedBox(height: 8),
                Text(
                  'Running ${busyState.operation}…',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.onSurfaceMuted, fontSize: 13),
                ),
                const SizedBox(height: 16),
              ],
              _Section(title: 'Clock', children: [
                _CommandTile(
                  icon: Icons.schedule_rounded,
                  title: 'Set Clock to Now',
                  subtitle: 'Writes device UTC time to meter',
                  enabled: !busy,
                  onTap: () => context.read<ProgrammingBloc>().add(
                        SetClockRequested(
                          meter: meter,
                          dateTime: DateTime.now().toUtc(),
                        ),
                      ),
                ),
              ]),
              const SizedBox(height: 12),
              _Section(title: 'Relay', children: [
                _CommandTile(
                  icon: Icons.power_rounded,
                  title: 'Connect Relay',
                  subtitle: 'Closes the internal disconnect switch',
                  enabled: !busy,
                  onTap: () => context.read<ProgrammingBloc>().add(
                        SetRelayRequested(meter: meter, connect: true),
                      ),
                ),
                const Divider(height: 1, color: AppColors.border),
                _CommandTile(
                  icon: Icons.power_off_rounded,
                  title: 'Disconnect Relay',
                  subtitle: 'Opens the internal disconnect switch',
                  iconColor: AppColors.error,
                  enabled: !busy,
                  onTap: () => context.read<ProgrammingBloc>().add(
                        SetRelayRequested(meter: meter, connect: false),
                      ),
                ),
              ]),
              const SizedBox(height: 12),
              _Section(title: 'Load Profile', children: [
                _CommandTile(
                  icon: Icons.show_chart_rounded,
                  title: 'Read Load Profile',
                  subtitle: '15-min interval energy data (class 7)',
                  enabled: !busy,
                  onTap: () => context.read<ProgrammingBloc>().add(
                        ReadLoadProfileRequested(
                          meter: meter,
                          obis: obisLoadProfile,
                          label: 'Load Profile',
                        ),
                      ),
                ),
                const Divider(height: 1, color: AppColors.border),
                _CommandTile(
                  icon: Icons.calendar_today_rounded,
                  title: 'Read Daily Profile',
                  subtitle: 'Daily energy totals (class 7)',
                  enabled: !busy,
                  onTap: () => context.read<ProgrammingBloc>().add(
                        ReadLoadProfileRequested(
                          meter: meter,
                          obis: obisDailyProfile,
                          label: 'Daily Profile',
                        ),
                      ),
                ),
              ]),
              // Profile data table
              if (state is ProgrammingProfileLoaded) ...[
                const SizedBox(height: 16),
                _ProfileTable(
                  label: state.label,
                  entries: state.entries,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: AppColors.onSurfaceMuted,
              fontSize: 11,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _CommandTile extends StatelessWidget {
  const _CommandTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.enabled = true,
    this.iconColor = AppColors.primary,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool enabled;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      leading: Icon(icon, color: enabled ? iconColor : AppColors.onSurfaceMuted),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.onSurface, fontSize: 14),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppColors.onSurfaceMuted, fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right_rounded,
          color: AppColors.onSurfaceMuted, size: 18),
      onTap: enabled ? onTap : null,
    );
  }
}

class _ProfileTable extends StatelessWidget {
  const _ProfileTable({required this.label, required this.entries});
  final String label;
  final List<ProfileEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            '${label.toUpperCase()} — ${entries.length} ENTRIES',
            style: const TextStyle(
              color: AppColors.onSurfaceMuted,
              fontSize: 11,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (entries.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Text('No entries in profile buffer',
                  style: TextStyle(color: AppColors.onSurfaceMuted)),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entries.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: AppColors.border),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                child: Text(
                  entries[i].toString(),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
