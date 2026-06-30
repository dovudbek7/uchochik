import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uchochik/app/theme/app_colors.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/domain/repositories/i_meter_repository.dart';
import 'package:uchochik/features/concentrator_form/screens/concentrator_form_screen.dart';
import 'package:uchochik/features/connection/screens/connection_screen.dart';
import 'package:uchochik/features/logs/screens/logs_screen.dart';
import 'package:uchochik/features/meter_detail/screens/meter_detail_screen.dart';
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

class _AsyncProgrammingScreen extends StatefulWidget {
  const _AsyncProgrammingScreen({required this.meterId});
  final int meterId;

  @override
  State<_AsyncProgrammingScreen> createState() =>
      _AsyncProgrammingScreenState();
}

class _AsyncProgrammingScreenState extends State<_AsyncProgrammingScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<IMeterRepository>().getById(widget.meterId),
      builder: (context, snap) {
        if (!snap.hasData) {
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

// Placeholder until meter form is implemented.
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
