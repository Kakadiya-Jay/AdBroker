// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

TextTheme LightThemeText() {
  return const TextTheme(
    displayLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: Color(0xff19404D),
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Color(0xff19404D),
    ),
    labelLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Color(0xff19404D),
    ),
    labelMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xff19404D),
    ),
    displayMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Color(0xff19404D),
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xff19404D),
    ),
    titleSmall: TextStyle(
      color: Color(0xff19404D),
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      color: Color(0xff19404D),
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Color(0xff19404D),
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
  );
}
