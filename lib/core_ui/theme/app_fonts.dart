import 'package:flutter/material.dart';

class AppFonts {
  static const String _openSans = 'Open Sans';
  static TextStyle openSans({
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? fontSize,
    double? height,
    Color? color,
  }) =>
      TextStyle(
        color: color,
        height: height,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        fontFamily: _openSans,
      );
}
