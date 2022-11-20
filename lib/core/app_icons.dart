import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  static String get icon_1 => 'assets/icons/icon_1.svg';
  static String get icon_2 => 'assets/icons/icon_2.svg';
  static String get icon_3 => 'assets/icons/icon_3.svg';
  static String get icon_4 => 'assets/icons/icon_4.svg';
  static String get icon_5 => 'assets/icons/icon_5.svg';
  static String get icon_6 => 'assets/icons/icon_6.svg';
  static String get icon_7 => 'assets/icons/icon_7.svg';

  static String get icon_avatar => 'assets/icons/avatar_default.svg';

  static String get trophy => 'assets/icons/icon_trophy.svg';
  static String get dislike => 'assets/icons/icon_dislike.svg';
  static String get like => 'assets/icons/icon_like.svg';

  static final List<String> defaultIcons = [
    AppIcons.icon_1,
    AppIcons.icon_2,
    AppIcons.icon_3,
    AppIcons.icon_4,
    AppIcons.icon_5,
    AppIcons.icon_6,
    AppIcons.icon_7,
  ];

  static String randomIcon() {
    int a = Random().nextInt(7);
    return defaultIcons[a];
  }
}

class CustomIconSVG extends StatelessWidget {
  const CustomIconSVG({Key? key, this.color, this.iconName}) : super(key: key);
  final Color? color;
  final String? iconName;

  @override
  Widget build(BuildContext context) {
    //TODO CHange to network validation icon
    return SvgPicture.asset(
      iconName.toString(),
      color: color,
      fit: BoxFit.contain,
      clipBehavior: Clip.antiAlias,
    );
  }
}
