import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/domain/repositories/i_meter_repository.dart';
import 'package:uchochik/features/concentrator_form/screens/concentrator_form_screen.dart';
import 'package:uchochik/features/connection/screens/connection_screen.dart';
import 'package:uchochik/features/logs/screens/logs_screen.dart';
import 'package:uchochik/features/meter_detail/screens/meter_detail_screen.dart';
import 'package:uchochik/features/meter_form/screens/meter_form_screen.dart';
import 'package:uchochik/features/network_tree/screens/network_tree_screen.dart';
import 'package:uchochik/features/programming/screens/programming_screen.dart';

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
      // New meter form — requires concentratorId in path
      GoRoute(
        path: '/concentrator/:cid/meter/new',
        builder: (_, state) {
          final cid = int.parse(state.pathParameters['cid']!);
          return MeterFormScreen(concentratorId: cid);
        },
      ),
      GoRoute(
        path: '/meter/:id',
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return MeterDetailScreen(meterId: id);
        },
      ),
      // Edit existing meter
      GoRoute(
        path: '/meter/:id/edit',
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return _AsyncMeterEditScreen(meterId: id);
        },
      ),
      GoRoute(
        path: '/connect/:id',
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ConnectionScreen(concentratorId: id);
        },
      ),
      GoRoute(
        path: '/logs',
        builder: (_, __) => const LogsScreen(),
      ),
      GoRoute(
        path: '/meter/:id/program',
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return _AsyncProgrammingScreen(meterId: id);
        },
      ),
    ],
  );
}

// ── Async screen loaders ──────────────────────────────────────────────────────

class _AsyncMeterEditScreen extends StatelessWidget {
  const _AsyncMeterEditScreen({required this.meterId});
  final int meterId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<IMeterRepository>().getById(meterId),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        final meter = snap.data;
        if (meter == null) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(title: const Text('Edit Meter')),
            body: const Center(
              child: Text('Meter not found',
                  style: TextStyle(color: AppColors.onSurfaceMuted)),
            ),
          );
        }
        return MeterFormScreen(meter: meter);
      },
    );
  }
}

class _AsyncProgrammingScreen extends StatelessWidget {
  const _AsyncProgrammingScreen({required this.meterId});
  final int meterId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<IMeterRepository>().getById(meterId),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        final meter = snap.data;
        if (meter == null) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(title: const Text('Program')),
            body: const Center(
              child: Text('Meter not found',
                  style: TextStyle(color: AppColors.onSurfaceMuted)),
            ),
          );
        }
        return ProgrammingScreen(meter: meter);
      },
    );
  }
}
