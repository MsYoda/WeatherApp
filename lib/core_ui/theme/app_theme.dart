import 'package:flutter/material.dart';
import 'package:test_task/core_ui/theme/app_colors.dart';

final _appColros = LightColors();

final ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primaryContainer: _appColros.primaryContainer,
    secondaryContainer: _appColros.secondaryConainer,
    surface: _appColros.surface,
    surfaceTint: _appColros.surfaceTint,
  ),
);
