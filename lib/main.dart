import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_task/core/localization/generated/codegen_loader.g.dart';
import 'package:test_task/core_ui/theme/app_theme.dart';
import 'package:test_task/di.dart';
import 'package:test_task/navigation/router.dart';

void main() async {
  initDependencies();
  await appLocator.allReady();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      ignorePluralRules: false,
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weather app',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: lightTheme,
      routerConfig: router,
    );
  }
}
