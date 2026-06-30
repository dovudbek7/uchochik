import 'package:flutter/material.dart';
import 'package:uchochik/app/app.dart';
import 'package:uchochik/core/di/injection.dart';
import 'package:uchochik/data/local/isar_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.instance.init();
  setupGetIt();
  runApp(const App());
}
