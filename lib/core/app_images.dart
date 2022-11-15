import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  static String get hierarchy => "assets/images/hierarchy.png";
  static String get data => "assets/images/data.png";
  static String get laptop => "assets/images/laptop.png";
  static String get blocks => "assets/images/blocks.png";
  static String get check => "assets/images/check.png";
  static String get error => "assets/images/error.png";
  static String get trophy => "assets/images/trophy.png";
  static String get logo => "assets/images/icon_app.png";
  static String get logoColorful => "assets/images/icon_app_color.png";
  static String get colorfulLogo => "assets/images/colorful_logo.png";
  static String get blackgroundLogo => "assets/images/blackground-logo.png";
  static String get badResult => "assets/images/bad-review.png";
  static String get mediumResult => "assets/images/positive-vote.png";
  static String get avatar => "assets/images/profile_1280.png";

  static String get onBoarding_1 =>
      'assets/onboarding/onboarding-navegacion.svg';
  static String get onBoarding_2 =>
      'assets/onboarding/onboarding-enseñanza-trad.svg';
  static String get onBoarding_3 => 'assets/onboarding/onboarding-notas.svg';

  static String get icon_1 => 'assets/icons/Artboard-26.svg';
  static String get icon_2 => 'assets/icons/Artboard-1.svg';
  static String get icon_3 => 'assets/icons/Artboard-6.svg';
  // ignore: non_constant_identifier_names
  static String get icon_trophy => 'assets/icons/Artboard-15.svg';
}

class CustomIconSVG extends StatelessWidget {
  const CustomIconSVG({Key? key, this.color, this.iconName}) : super(key: key);
  final Color? color;
  final String? iconName;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconName.toString(),
      color: color,
    );
  }
}
