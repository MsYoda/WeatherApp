import 'package:flutter/material.dart';

abstract class AppColors {
  Color get surface;
  Color get surfaceTint;
  Color get primaryContainer;
  Color get secondaryConainer;
}

class LightColors extends AppColors {
  @override
  Color get primaryContainer => Colors.white;

  @override
  Color get secondaryConainer => Colors.black;

  @override
  Color get surface => const Color.fromRGBO(43, 50, 178, 1);

  @override
  Color get surfaceTint => const Color.fromRGBO(20, 136, 204, 1);
}
