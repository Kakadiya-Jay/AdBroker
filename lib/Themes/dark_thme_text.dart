// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

TextTheme DarkThemeText() {
  return const TextTheme(
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Color(0xfff9feff),
    ),
    labelLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Color.fromARGB(255, 13, 13, 13),
    ),
    labelMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(255, 13, 13, 13),
    ),
    displayMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Color(0xfff9feff),
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xfff9feff),
    ),
    titleSmall: TextStyle(
      color: Color(0xFFF9F9F9),
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      color: Color(0xFFF9F9F9),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: Color(0xFFE6E6E7),
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
  );
}
