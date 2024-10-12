import 'package:flutter/material.dart';
import 'package:test_task/core_ui/theme/app_theme.dart';
import 'package:test_task/navigation/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      routerConfig: router,
    );
  }
}
