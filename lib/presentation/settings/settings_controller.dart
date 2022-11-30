import 'package:trivia_educativa/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kThemeKey = 'appTheme';

class SettingsController {
  final SharedPreferences _sharedPreferences;
  SettingsController(
    this._sharedPreferences,
    Object object,
  ) {
    init();
  }

  ValueNotifier<ThemeData> themeNotifier =
      ValueNotifier<ThemeData>(AppTheme.lightTheme);
  ThemeData get currentAppTheme => themeNotifier.value;
  set currentAppTheme(ThemeData value) => themeNotifier.value = value;

  init() {
    final theme = _sharedPreferences.getString(_kThemeKey);
    changeCurrentAppTheme(
      theme: theme,
    );
  }

  void changeCurrentAppTheme({
    String? theme,
  }) async {
    if (theme != null) {
      if (theme.toLowerCase() == "dark") {
        _setDarkTheme();
      } else {
        _setLightTheme();
      }
    } else {
      if (currentAppTheme == AppTheme.lightTheme) {
        _setDarkTheme();
      } else if (currentAppTheme == AppTheme.darkTheme) {
        _setLightTheme();
      }
    }
  }

  void _setDarkTheme() {
    currentAppTheme = AppTheme.darkTheme;
    _sharedPreferences.setString(_kThemeKey, "dark");
  }

  void _setLightTheme() {
    currentAppTheme = AppTheme.lightTheme;
    _sharedPreferences.setString(_kThemeKey, "light");
  }
}
