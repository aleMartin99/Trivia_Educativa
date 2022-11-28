import 'package:flutter/material.dart';

import '/../core/core.dart';

import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class NextButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  late Color fontColor;
  final Color borderColor;
  final Color overlayColor;
  final VoidCallback onTap;
  late TextStyle textStyle;

  NextButtonWidget({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.overlayColor,
    required this.onTap,
  }) : super(key: key);

  // Creando constructores con nombre para diferentes situaciones
  NextButtonWidget.green({Key? key, required this.label, required this.onTap})
      : backgroundColor = AppColors.darkGreen,
        borderColor = AppColors.darkGreen,
        overlayColor = AppColors.lightGreen,
        textStyle = GoogleFonts.notoSans(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: AppColors.white,
        ),
        super(key: key);

  NextButtonWidget.white({Key? key, required this.label, required this.onTap})
      : backgroundColor = AppColors.white,
        borderColor = Colors.transparent,
        overlayColor = AppColors.lightGrey,
        textStyle = GoogleFonts.notoSans(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: AppColors.grey,
        ),
        super(key: key);

  NextButtonWidget.purple({Key? key, required this.label, required this.onTap})
      : backgroundColor = AppColors.purple,
        borderColor = AppColors.purple,
        overlayColor = AppColors.purple,
        textStyle = GoogleFonts.notoSans(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: AppColors.white,
        ),
        super(key: key);
  NextButtonWidget.transparent(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.fontColor})
      : backgroundColor = Colors.transparent,
        borderColor = Colors.transparent,
        overlayColor = AppColors.lightGrey,
        textStyle = GoogleFonts.notoSans(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: fontColor,
            decoration: TextDecoration.underline,
            decorationThickness: 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 400,
      decoration: const BoxDecoration(),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          overlayColor: MaterialStateProperty.all(overlayColor),
        ),
        onPressed: onTap,
        child: Text(label,
            //TODO check font family and remove notoSans
            style: textStyle),
      ),
    );
  }
}
