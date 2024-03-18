import 'package:ad_brokers/Themes/dark_thme_text.dart';
import 'package:ad_brokers/Themes/light_thme_text.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Poppins",
      scaffoldBackgroundColor: const Color(0xfff5f5f5),
      canvasColor: const Color.fromRGBO(210, 244, 253, 1),
      cardColor: const Color(0xfff2f2f2),
      shadowColor: const Color(0xff163648),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFFFFF),
        selectedItemColor: Color(0xFF674DEA),
        unselectedItemColor: Color(0xFFB4B5B8),
      ),
      textTheme: LightThemeText(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Poppins",
      // scaffoldBackgroundColor: const Color(0xff2b2b2b),
      scaffoldBackgroundColor: const Color(0xff241D2A),
      canvasColor: const Color(0xff163648),
      // cardColor: const Color(0xff4b4b4b),
      cardColor: const Color(0xff37303F),
      shadowColor: const Color.fromRGBO(210, 244, 253, 1),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(46, 38, 52, 0.9),
        selectedItemColor: Color(0xFFFFC228),
        unselectedItemColor: Color(0xFF9380A6),
      ),
      textTheme: DarkThemeText(),
    );
  }
}
