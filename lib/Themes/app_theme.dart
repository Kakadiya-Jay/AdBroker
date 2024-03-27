import 'package:ad_brokers/Themes/dark_thme_text.dart';
import 'package:ad_brokers/Themes/dark_widget_theme.dart';
import 'package:ad_brokers/Themes/light_thme_text.dart';
import 'package:ad_brokers/Themes/light_widget_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Poppins",
      scaffoldBackgroundColor: const Color(0xfff5f5f5),
      // canvasColor: const Color(0xfff5f5f5),
      canvasColor: const Color(0xffFFFFFF),
      cardColor: const Color(0xfff2f2f2),
      shadowColor: const Color(0xff163648),
      textTheme: LightThemeText(),
      bottomNavigationBarTheme: LightWidgetTheme.bottomNavigationBarTheme(),
      inputDecorationTheme: LightWidgetTheme.inputDecorationTheme(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Poppins",
      // scaffoldBackgroundColor: const Color(0xff2b2b2b),
      scaffoldBackgroundColor: const Color(0xff241D2A),
      canvasColor: const Color(0xff403747),
      // cardColor: const Color(0xff4b4b4b),
      cardColor: const Color(0xff37303F),
      shadowColor: const Color.fromRGBO(210, 244, 253, 1),
      textTheme: DarkThemeText(),
      bottomNavigationBarTheme: DarkWidgetTheme.bottomNavigationBarTheme(),
      inputDecorationTheme: DarkWidgetTheme.inputDecorationTheme(),
    );
  }
}
