import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double value;

  const ProgressIndicatorWidget({Key? key, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: AppColors.chartSecondary,
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
    );
  }
}
