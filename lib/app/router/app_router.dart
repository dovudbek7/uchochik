import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/features/concentrator_form/screens/concentrator_form_screen.dart';
import 'package:uchochik/features/meter_detail/screens/meter_detail_screen.dart';
import 'package:uchochik/features/network_tree/screens/network_tree_screen.dart';

abstract final class AppRouter {
  static final config = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const NetworkTreeScreen(),
      ),
      GoRoute(
        path: '/concentrator/new',
        builder: (_, __) => const ConcentratorFormScreen(),
      ),
      GoRoute(
        path: '/meter/:id',
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return MeterDetailScreen(meterId: id);
        },
      ),
      GoRoute(
        path: '/meter/new',
        builder: (_, __) => const _MeterFormPlaceholder(),
      ),
    ],
  );
}

// Placeholder until Step 3 (transport layer) is ready.
class _MeterFormPlaceholder extends StatelessWidget {
  const _MeterFormPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Meter')),
      body: const Center(
        child: Text(
          'Meter form — available in Step 3\n(requires transport layer)',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.onSurfaceMuted),
        ),
      ),
    );
  }
}
