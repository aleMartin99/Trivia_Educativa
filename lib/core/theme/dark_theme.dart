import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trivia_educativa/core/theme/page_transitions.dart';
import 'package:trivia_educativa/core/theme/text_theme.dart';

///Theme Dark
final ThemeData themeDark = ThemeData(
  errorColor: const Color(0xffFF6666),
  brightness: Brightness.dark,
  cardTheme: CardTheme(
    shadowColor: Colors.black.withOpacity(0.8),
    elevation: 1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    // color: Color(0XFF223340),
    color: const Color(0xff3D3D3D),
  ),
  primaryIconTheme: const IconThemeData(
    color: Colors.white,
  ),
  listTileTheme: const ListTileThemeData(textColor: Colors.white),
  splashFactory: InkRipple.splashFactory,
  canvasColor: const Color(0xff121212),
  textTheme: textDarkTheme,
  primaryColor: const Color(0xFF57B6E0),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xFF57B6E0),
    textTheme: CupertinoTextThemeData(
      primaryColor: Color(0xff3EE78A),
      tabLabelTextStyle: TextStyle(
        fontSize: 10,
        color: white,
        fontFamily: 'PNBold',
      ),
    ),
  ),
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
      color: white,
      fontFamily: 'PNRegular',
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      color: Colors.grey,
      fontFamily: 'PNRegular',
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF57B6E0),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xff121212),
    thickness: 0.5,
    indent: 20,
    endIndent: 20,
  ),
  dividerColor: const Color(0xff696969),
  iconTheme: iconThemeDataDark,
  appBarTheme: appBarThemeDark,
  pageTransitionsTheme: pageTransitions,
  fontFamily: 'PNRegular',
  backgroundColor: const Color(0xff1e1e1e),
  bottomAppBarTheme: bottomAppBarThemeDark,
  cardColor: const Color(0xff3D3D3D),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedLabelStyle: TextStyle(
      fontFamily: 'PNBold',
      fontSize: 12,
    ),
    selectedLabelStyle: TextStyle(
      fontFamily: 'PNBold',
      fontSize: 12,
    ),
    selectedIconTheme: IconThemeData(
      size: 22,
    ),
    unselectedIconTheme: IconThemeData(
      size: 22,
    ),
  ),
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

    brightness: Brightness.dark,
    // primary: orange,
  ),
);

BottomAppBarTheme bottomAppBarThemeDark = const BottomAppBarTheme(
  color: Colors.transparent,
  elevation: 0.5,
);
AppBarTheme appBarThemeDark = const AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  foregroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
);

IconThemeData iconThemeDataDark = const IconThemeData(
  color: Colors.white,
  size: 24,
);

final systemDarkTheme = SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: const Color(0xff1e1e1e),
  systemNavigationBarIconBrightness: Brightness.light,
);
