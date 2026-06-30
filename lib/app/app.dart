import 'package:flutter/material.dart';
import 'package:uchochik/app/router/app_router.dart';
import 'package:uchochik/app/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Uchochik',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.config,
    );
  }
}
