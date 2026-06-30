import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/domain/entities/concentrator.dart';
import 'package:uchochik/domain/enums/communication_type.dart';
import 'package:uchochik/domain/repositories/i_concentrator_repository.dart';
import 'package:uchochik/features/connection/bloc/connection_bloc.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key, required this.concentratorId});
  final int concentratorId;

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  Concentrator? _concentrator;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final c = await getIt<IConcentratorRepository>()
        .getById(widget.concentratorId);
    if (mounted) setState(() => _concentrator = c);
  }

  @override
  Widget build(BuildContext context) {
    if (_concentrator == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }
    return BlocConsumer<ConnectionBloc, ConnectionState>(
      listener: (context, state) {
        if (state is ConnectionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) => _buildScaffold(context, state),
    );
  }

  Widget _buildScaffold(BuildContext context, ConnectionState state) {
    final bloc = context.read<ConnectionBloc>();
    final c = _concentrator!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(c.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _ConcentratorCard(concentrator: c),
          const SizedBox(height: 24),
          _StatusCard(state: state),
          const SizedBox(height: 24),
          _ActionButton(
            state: state,
            onConnect: () =>
                bloc.add(ConnectRequested(concentrator: c)),
            onDisconnect: () => bloc.add(DisconnectRequested()),
          ),
          if (state is ConnectionActive) ...[
            const SizedBox(height: 16),
            _ConnectedStats(state: state),
          ],
        ],
      ),
    );
  }
}

// ── Widgets ──────────────────────────────────────────────────────────────────

class _ConcentratorCard extends StatelessWidget {
  const _ConcentratorCard({required this.concentrator});
  final Concentrator concentrator;

  @override
  Widget build(BuildContext context) {
    final isTcp = concentrator.communicationType == CommunicationType.tcpIp;
    final address = isTcp
        ? '${concentrator.ipAddress ?? '—'}:${concentrator.port ?? '—'}'
        : concentrator.serialPortDevice ?? '—';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isTcp ? Icons.router_rounded : Icons.usb_rounded,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(concentrator.name,
                    style: const TextStyle(
                        color: AppColors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(address,
                    style: const TextStyle(
                        color: AppColors.onSurfaceMuted,
                        fontSize: 13,
                        fontFamily: 'monospace')),
                const SizedBox(height: 2),
                Text(concentrator.communicationType.displayName,
                    style: const TextStyle(
                        color: AppColors.primary, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.state});
  final ConnectionState state;

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = switch (state) {
      ConnectionIdle() => ('Disconnected', AppColors.offline, Icons.circle_outlined),
      ConnectionConnecting(:final concentrator) => (
          'Connecting to ${concentrator.name}…',
          AppColors.warning,
          Icons.sync_rounded,
        ),
      ConnectionActive(:final connectedAt) => (
          'Connected · ${_elapsed(connectedAt)}',
          AppColors.online,
          Icons.circle_rounded,
        ),
      ConnectionFailed() => ('Connection failed', AppColors.error, Icons.error_outline_rounded),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          if (state is ConnectionConnecting)
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: color),
            )
          else
            Icon(icon, color: color, size: 18),
          const SizedBox(width: 12),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _elapsed(DateTime since) {
    final d = DateTime.now().difference(since);
    if (d.inSeconds < 60) return '${d.inSeconds}s';
    return '${d.inMinutes}m ${d.inSeconds % 60}s';
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.state,
    required this.onConnect,
    required this.onDisconnect,
  });
  final ConnectionState state;
  final VoidCallback onConnect;
  final VoidCallback onDisconnect;

  @override
  Widget build(BuildContext context) {
    final isConnecting = state is ConnectionConnecting;
    final isConnected = state is ConnectionActive;

    if (isConnected) {
      return OutlinedButton.icon(
        onPressed: onDisconnect,
        icon: const Icon(Icons.link_off_rounded, size: 18),
        label: const Text('Disconnect'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: const BorderSide(color: AppColors.error),
          minimumSize: const Size(double.infinity, 52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: isConnecting ? null : onConnect,
      icon: const Icon(Icons.link_rounded, size: 18),
      label:
          Text(isConnecting ? 'Connecting…' : 'Connect'),
    );
  }
}

class _ConnectedStats extends StatelessWidget {
  const _ConnectedStats({required this.state});
  final ConnectionActive state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Session',
              style: TextStyle(
                  color: AppColors.onSurfaceMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2)),
          const SizedBox(height: 10),
          _StatRow(label: 'Connected at',
              value: _fmt(state.connectedAt)),
          _StatRow(label: 'Concentrator SN',
              value: state.concentrator.serialNumber),
          _StatRow(label: 'Transport',
              value: state.concentrator.communicationType.displayName),
          const SizedBox(height: 8),
          const Text(
            'DLMS session layer — Step 4',
            style:
                TextStyle(color: AppColors.onSurfaceMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
              width: 130,
              child: Text(label,
                  style: const TextStyle(
                      color: AppColors.onSurfaceMuted, fontSize: 13))),
          Expanded(
              child: Text(value,
                  style: const TextStyle(
                      color: AppColors.onSurface,
                      fontSize: 13,
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
