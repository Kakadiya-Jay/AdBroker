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
      textTheme: LightThemeText(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Poppins",
      scaffoldBackgroundColor: const Color(0xff2b2b2b),
      canvasColor: const Color(0xff163648),
      cardColor: const Color(0xff4b4b4b),
      shadowColor: const Color.fromRGBO(210, 244, 253, 1),
      textTheme: DarkThemeText(),
    );
  }
}
