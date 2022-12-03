import 'package:flutter/material.dart';
import 'package:trivia_educativa/core/app_colors.dart';

const black = AppColors.black;
const white = Colors.white;

const TextTheme textLightTheme = TextTheme(
  headline1: TextStyle(
    fontSize: 60,
    fontFamily: 'PNBold',
    color: black,
  ),
  headline2: TextStyle(
    fontSize: 24,
    fontFamily: 'PNExtraBold',
    // fontWeight: FontWeight.w500,
    color: black,
  ),
  headline3: TextStyle(
    fontSize: 24,
    fontFamily: 'PNBold',
    color: black,
  ),
  headline4: TextStyle(
    fontSize: 32,
    color: black,
    fontFamily: 'PNBold',
  ),
  headline5: TextStyle(
    fontSize: 18,
    fontFamily: 'PNBold',
    color: white,
  ),
  headline6: TextStyle(
    fontSize: 16,
    color: black,
    fontFamily: 'PNRegular',
  ),
  bodyText1: TextStyle(
    fontSize: 16,
    color: black,
    fontFamily: 'PNRegular',
  ),
  bodyText2: TextStyle(
    fontSize: 14,
    color: black,
    fontFamily: 'PNRegular',
  ),
  subtitle1: TextStyle(
    fontSize: 14,
    color: Color(0xFFB1B1B1),
    fontFamily: 'PNRegular',
  ),
  subtitle2: TextStyle(
    fontSize: 14,
    color: Color(0XFF1D99DD),
    fontFamily: 'PNRegular',
  ),
);

const TextTheme textDarkTheme = TextTheme(
  headline1: TextStyle(
    fontSize: 60,
    fontFamily: 'PNBold',
    color: white,
  ),
  headline2: TextStyle(
    fontSize: 24,
    fontFamily: 'PNExtraBold',
    //fontWeight: FontWeight.w500,
    color: white,
  ),
  headline3: TextStyle(
    fontSize: 24,
    fontFamily: 'PNBold',
    color: white,
  ),
  headline4: TextStyle(
    fontSize: 32,
    color: white,
    fontFamily: 'PNBold',
  ),
  headline5: TextStyle(
    fontSize: 18,
    fontFamily: 'PNBold',
    color: black,
  ),
  headline6: TextStyle(
    fontSize: 18,
    color: white,
    fontFamily: 'PNRegular',
  ),
  bodyText1: TextStyle(
    fontSize: 16,
    color: white,
    fontFamily: 'PNRegular',
  ),
  bodyText2: TextStyle(
    fontSize: 14,
    color: white,
    fontFamily: 'PNRegular',
  ),
  subtitle1: TextStyle(
    fontSize: 14,
    color: Color(0xFFB1B1B1),
    fontFamily: 'PNRegular',
  ),
  subtitle2: TextStyle(
    fontSize: 14,
    color: Color(0XFF1D99DD),
    fontFamily: 'PNRegular',
  ),
);

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontFamily: 'PNRegular',
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle titleBold = TextStyle(
    fontFamily: 'PNRegular',
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading = TextStyle(
    fontFamily: 'PNRegular',
    color: AppColors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle heading40 = TextStyle(
    fontFamily: 'PNRegular',
    color: AppColors.black,
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle regularText16 = TextStyle(
    fontFamily: 'PNRegular',
    fontSize: 16,
    //color: AppColors.black,
  );
}
