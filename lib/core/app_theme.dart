import 'package:trivia_educativa/core/core.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color backgroundColors(Brightness brightness) =>

      //TODO modify the white color to gray white 12
      brightness == Brightness.light
          ? AppColors.white
          : const Color(0xFF333333);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.black,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: AppColors.white,
    brightness: Brightness.dark,
  );
}
