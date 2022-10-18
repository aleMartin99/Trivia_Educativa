import 'package:trivia_educativa/core/core.dart';
import 'package:flutter/material.dart';

//TODO * Check modo oscuro y colores luego del reset se queda mareado

class AppTheme {
  static Color backgroundColors(Brightness brightness) =>
      brightness == Brightness.light
          ? AppColors.white
          : const Color(0xFF333333);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightPurple,
    primaryColor: AppColors.black,
    iconTheme: const IconThemeData(color: AppColors.white),
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: AppColors.white,
    iconTheme: const IconThemeData(color: AppColors.white),
    brightness: Brightness.dark,
  );
}
