import 'package:flutter/material.dart';

class DarkWidgetTheme {
  static bottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(46, 38, 52, 0.9),
      selectedItemColor: Color(0xFFFFC228),
      unselectedItemColor: Color(0xFF9380A6),
    );
  }

  static inputDecorationTheme() {
    return const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xff403747),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xfff9feff),
      ),
      hintStyle: TextStyle(
        color: Color(0xff9B9DA0),
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
          color: Color.fromARGB(255, 69, 72, 75),
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFF4F5359),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );
  }
}
