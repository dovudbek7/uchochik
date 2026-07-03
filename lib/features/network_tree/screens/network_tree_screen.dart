import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/features/network_tree/bloc/network_tree_bloc.dart';
import 'package:uchochik/features/network_tree/widgets/group_node_tile.dart';
import 'package:uchochik/features/usb_detection/widgets/usb_detection_banner.dart';

class NetworkTreeScreen extends StatelessWidget {
  const NetworkTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NetworkTreeBloc>()..add(LoadNetworkTree()),
      child: const _NetworkTreeView(),
    );
  }
}

class _NetworkTreeView extends StatelessWidget {
  const _NetworkTreeView();

  void _showAddGroupDialog(BuildContext context, NetworkTreeBloc bloc) {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        title: const Text('New Group',
            style: TextStyle(color: AppColors.onSurface)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: AppColors.onSurface),
          decoration: const InputDecoration(labelText: 'Group name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.onSurfaceMuted)),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                bloc.add(AddGroupRequested(name));
              }
              Navigator.pop(context);
            },
            child: const Text('Create',
                style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkTreeBloc, NetworkTreeState>(
      builder: (context, state) {
        final bloc = context.read<NetworkTreeBloc>();

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Row(
              children: [
                Icon(Icons.electrical_services_rounded,
                    color: AppColors.primary, size: 22),
                SizedBox(width: 10),
                Text('Uchochik'),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.create_new_folder_outlined),
                color: AppColors.onSurfaceMuted,
                tooltip: 'New Group',
                onPressed: () => _showAddGroupDialog(context, bloc),
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                color: AppColors.onSurfaceMuted,
                onPressed: () => bloc.add(LoadNetworkTree()),
              ),
            ],
          ),
          body: Column(
            children: [
              const UsbDetectionBanner(),
              Expanded(child: _buildBody(context, state, bloc)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.push('/concentrator/new'),
            tooltip: 'Add Concentrator',
            child: const Icon(Icons.add_rounded),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    NetworkTreeState state,
    NetworkTreeBloc bloc,
  ) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: AppColors.error, size: 48),
            const SizedBox(height: 12),
            Text(state.errorMessage!,
                style: const TextStyle(color: AppColors.onSurfaceMuted)),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => bloc.add(LoadNetworkTree()),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.isEmpty) {
      return _EmptyState(onAddConcentrator: () => context.push('/concentrator/new'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      itemCount: state.groups.length,
      itemBuilder: (_, i) {
        final groupNode = state.groups[i];
        return GroupNodeTile(
          node: groupNode,
          onToggle: () => bloc.add(ToggleGroupNode(groupNode.groupId)),
          onToggleConcentrator: (id) =>
              bloc.add(ToggleConcentratorNode(id)),
          onConnectConcentrator: (id) => context.push('/connect/$id'),
          onAddConcentrator: () => context.push('/concentrator/new'),
          onAddMeter: (cid) => context.push('/concentrator/$cid/meter/new'),
          onDeleteConcentrator: (id) => _confirmDelete(
            context,
            'Delete concentrator and all its meters?',
            () => bloc.add(DeleteConcentratorRequested(id)),
          ),
          onMeterTap: (meter) => context.push('/meter/${meter.id}'),
          onDeleteMeter: (id) => _confirmDelete(
            context,
            'Delete this meter?',
            () => bloc.add(DeleteMeterRequested(id)),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    String message,
    VoidCallback onConfirm,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        title: const Text('Confirm', style: TextStyle(color: AppColors.onSurface)),
        content: Text(message,
            style: const TextStyle(color: AppColors.onSurfaceMuted)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.onSurfaceMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (ok == true) onConfirm();
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAddConcentrator});
  final VoidCallback onAddConcentrator;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.electrical_services_rounded,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No devices configured',
              style: TextStyle(
                color: AppColors.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add a concentrator to start\ncommunicating with meters.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.onSurfaceMuted, height: 1.5),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: onAddConcentrator,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Add Concentrator'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
