import 'package:final_moviles/utils/text_theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeConstants extends GetxController {
  ThemeConstants._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TextThemeConstants.lightTextTheme,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButton.styleFrom()));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TextThemeConstants.darkTextTheme);
}
