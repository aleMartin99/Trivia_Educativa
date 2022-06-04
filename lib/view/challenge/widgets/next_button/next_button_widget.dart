import 'package:educational_quiz_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color fontColor;
  final Color borderColor;
  final Color overlayColor;
  final VoidCallback onTap;

  const NextButtonWidget({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.fontColor,
    required this.borderColor,
    required this.overlayColor,
    required this.onTap,
  }) : super(key: key);

  // Criando construtores nomeados para diferentes situacoes
  const NextButtonWidget.green(
      {Key? key, required String label, required VoidCallback onTap})
      : backgroundColor = AppColors.darkGreen,
        fontColor = AppColors.white,
        borderColor = AppColors.darkGreen,
        overlayColor = AppColors.lightGreen,
        onTap = onTap,
        label = label,
        super(key: key);

  const NextButtonWidget.white(
      {Key? key, required String label, required VoidCallback onTap})
      : backgroundColor = AppColors.white,
        fontColor = AppColors.grey,
        borderColor = Colors.transparent,
        overlayColor = AppColors.lightGrey,
        onTap = onTap,
        label = label,
        super(key: key);

  const NextButtonWidget.purple(
      {Key? key, required String label, required VoidCallback onTap})
      : backgroundColor = AppColors.purple,
        fontColor = AppColors.white,
        borderColor = AppColors.purple,
        overlayColor = AppColors.purple,
        onTap = onTap,
        label = label,
        super(key: key);

  const NextButtonWidget.transparent(
      {Key? key, required String label, required VoidCallback onTap})
      : backgroundColor = Colors.transparent,
        fontColor = AppColors.grey,
        borderColor = Colors.transparent,
        overlayColor = AppColors.lightGrey,
        onTap = onTap,
        label = label,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // side: this.borderColor!=Colors.transparent ? MaterialStateProperty.all(
          //   BorderSide(
          //     color: AppColors.border,
          //   ),
          // ) : null,
          overlayColor: MaterialStateProperty.all(overlayColor),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
