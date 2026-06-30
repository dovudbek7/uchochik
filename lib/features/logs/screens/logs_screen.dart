import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/domain/entities/operation_log.dart';
import 'package:uchochik/domain/enums/operation_status.dart';
import 'package:uchochik/domain/repositories/i_operation_log_repository.dart';
import 'package:uchochik/features/logs/bloc/logs_bloc.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LogsBloc(repository: getIt<IOperationLogRepository>())
        ..add(const LogsLoadRequested()),
      child: const _LogsBody(),
    );
  }
}

class _LogsBody extends StatelessWidget {
  const _LogsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Operation Logs'),
        actions: [
          BlocBuilder<LogsBloc, LogsState>(
            builder: (context, state) => IconButton(
              icon: const Icon(Icons.delete_sweep_rounded),
              tooltip: 'Purge logs older than 30 days',
              onPressed: () =>
                  context.read<LogsBloc>().add(const LogsPurgeRequested()),
            ),
          ),
        ],
      ),
      body: BlocBuilder<LogsBloc, LogsState>(
        builder: (context, state) => switch (state) {
          LogsInitial() || LogsLoading() => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          LogsLoaded(logs: final logs) when logs.isEmpty => const Center(
              child: Text('No operation logs yet.',
                  style: TextStyle(color: AppColors.onSurfaceMuted)),
            ),
          LogsLoaded(logs: final logs) => RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async =>
                  context.read<LogsBloc>().add(const LogsLoadRequested()),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: logs.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: AppColors.border),
                itemBuilder: (_, i) => _LogTile(log: logs[i]),
              ),
            ),
          LogsError(message: final m) => Center(
              child: Text(m,
                  style:
                      const TextStyle(color: AppColors.error, fontSize: 13)),
            ),
        },
      ),
    );
  }
}

class _LogTile extends StatelessWidget {
  const _LogTile({required this.log});
  final OperationLog log;

  @override
  Widget build(BuildContext context) {
    final ok = log.status == OperationStatus.success;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: (ok ? AppColors.primary : AppColors.error).withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ok ? Icons.check_rounded : Icons.close_rounded,
              size: 16,
              color: ok ? AppColors.primary : AppColors.error,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      log.operation,
                      style: const TextStyle(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${log.durationMs} ms',
                      style: const TextStyle(
                          color: AppColors.onSurfaceMuted, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  log.errorMessage ?? _fmtTime(log.timestamp),
                  style: TextStyle(
                    color: log.errorMessage != null
                        ? AppColors.error
                        : AppColors.onSurfaceMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fmtTime(DateTime dt) {
    final l = dt.toLocal();
    return '${l.year}-${_p(l.month)}-${_p(l.day)} '
        '${_p(l.hour)}:${_p(l.minute)}:${_p(l.second)}';
  }

  String _p(int v) => v.toString().padLeft(2, '0');
}

/// Inline log list for meter-detail tab — reuses _LogTile.
class MeterLogsTab extends StatelessWidget {
  const MeterLogsTab({super.key, required this.meterId});
  final int meterId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          LogsBloc(repository: getIt<IOperationLogRepository>())
            ..add(LogsMeterFilterSet(meterId))
            ..add(const LogsLoadRequested()),
      child: BlocBuilder<LogsBloc, LogsState>(
        builder: (context, state) => switch (state) {
          LogsInitial() || LogsLoading() => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          LogsLoaded(logs: final logs) when logs.isEmpty => const Center(
              child: Text('No logs for this meter.',
                  style: TextStyle(color: AppColors.onSurfaceMuted)),
            ),
          LogsLoaded(logs: final logs) => RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async => context
                  .read<LogsBloc>()
                  .add(const LogsLoadRequested()),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: logs.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: AppColors.border),
                itemBuilder: (_, i) => _LogTile(log: logs[i]),
              ),
            ),
          LogsError(message: final m) => Center(
              child: Text(m,
                  style:
                      const TextStyle(color: AppColors.error, fontSize: 13)),
            ),
        },
      ),
    );
  }
}
