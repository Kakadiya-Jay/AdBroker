import 'package:flutter/material.dart';

class LightWidgetTheme {
  static bottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      selectedItemColor: Color(0xFF674DEA),
      unselectedItemColor: Color(0xFFB4B5B8),
    );
  }

  static inputDecorationTheme() {
    return const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFFFFFFF),
      labelStyle: TextStyle(
        fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xff19404D),
      ),
      hintStyle: TextStyle(
        color: Color(0xff818488),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF674DEA),
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFB4B5B8),
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFFE6E6E7),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );
  }
}
