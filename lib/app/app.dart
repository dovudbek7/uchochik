import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchochik/app/router/app_router.dart';
import 'package:uchochik/app/theme/app_theme.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/features/connection/bloc/connection_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ConnectionBloc>(),
      child: MaterialApp.router(
        title: 'Uchochik',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        routerConfig: AppRouter.config,
      ),
    );
  }
}
