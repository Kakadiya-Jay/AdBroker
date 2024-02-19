// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

TextTheme LightThemeText() {
  return const TextTheme(
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Color(0xff19404D),
    ),
    labelLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Color.fromARGB(255, 13, 13, 13),
    ),
    labelMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Color.fromARGB(255, 13, 13, 13),
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
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: Color(0xff19404D),
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
  );
}
