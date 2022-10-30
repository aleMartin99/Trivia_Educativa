import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trivia_educativa/core/theme/page_transitions.dart';

import 'package:trivia_educativa/core/theme/text_theme.dart';

import '../app_colors.dart';

//TODO fix colors, modes and test

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

Color backgroundColors(Brightness brightness) =>
    brightness == Brightness.light ? AppColors.white : const Color(0xFF333333);

///Theme Light
final ThemeData themeLight = ThemeData(
  errorColor: const Color(0xffFF6666),
  // cupertinoOverrideTheme: CupertinoThemeData(),
  primaryIconTheme: const IconThemeData(
    color: AppColors.black,
  ),
  brightness: Brightness.light,

  scaffoldBackgroundColor: AppColors.lightPurple,
  textTheme: textLightTheme,
  splashFactory: InkRipple.splashFactory,
  canvasColor: const Color(0xffF9F9F9),
  // textTheme: textTheme,
  // platform: TargetPlatform.android,
  cardColor: const Color(0xffF9F9F9),
  // cardTheme: const CardTheme(
  //   color: Color(0xffF9F9F9),
  //   elevation: 0,
  // ),685639373
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xFF57B6E0),
    textTheme: CupertinoTextThemeData(
      primaryColor: Color(0xff3EE78A),
      tabLabelTextStyle: TextStyle(
        fontSize: 10,
        color: black,
        fontFamily: 'PNBold',
      ),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF57B6E0),
  ),

  dividerColor: const Color(0xffD2D2D2),
  fontFamily: 'PNRegular',
  primaryColor: const Color(0xFF57B6E0),
// primaryColor: const Color(0xff1D99DD),
  // tabBarTheme: tabBarThemeLight,

  dividerTheme: const DividerThemeData(
    color: Color(0xffF9F9F9),
    thickness: 0.5,
    indent: 16,
    endIndent: 16,
  ),
  //? commented
  iconTheme: iconThemeDataLight,
  // appBarTheme: appBarThemeLight,
  inputDecorationTheme: const InputDecorationTheme(
    filled: false,
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff696969),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff696969),
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff696969),
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF57B6E0),
      ),
    ),
    labelStyle: TextStyle(
      fontSize: 16,
      color: black,
      fontFamily: 'PNRegular',
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      color: Colors.grey,
      fontFamily: 'PNRegular',
    ),
  ),

  pageTransitionsTheme: pageTransitions,
  backgroundColor: Colors.white,
  //bottomAppBarTheme: bottomAppBarThemeLight,
  // cupertinoOverrideTheme: CupertinoTheme(),

  colorScheme: ColorScheme.fromSwatch(
    accentColor: const Color(0xff1FD970),
    primarySwatch: const MaterialColor(
      400,
      {
        100: Color(0xFF57B6E0),
        200: Color(0xFF57B6E0),
        300: Color(0xFF57B6E0),
        400: Color(0xFF57B6E0),
        500: Color(0xFF57B6E0),
        600: Color(0xFF57B6E0),
        700: Color(0xFF57B6E0),
        800: Color(0xFF57B6E0),
        900: Color(0xFF57B6E0),
      },
    ),
    // primary: orange,
  ),
);

BottomAppBarTheme bottomAppBarThemeLight = const BottomAppBarTheme(
  color: Colors.transparent,
  elevation: 0.5,
);
AppBarTheme appBarThemeLight = const AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  foregroundColor: Colors.black,
);

IconThemeData iconThemeDataLight = const IconThemeData(
  color: Colors.white,
  size: 24,
);

final systemLightTheme = SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: Colors.black,
  systemNavigationBarIconBrightness: Brightness.light,
);
