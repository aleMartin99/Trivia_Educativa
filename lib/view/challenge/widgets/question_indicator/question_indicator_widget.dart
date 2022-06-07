import 'package:educational_quiz_app/view/settings/settings_controller.dart';
import 'package:educational_quiz_app/view/shared/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';

import 'package:educational_quiz_app/core/core.dart';
import 'package:provider/provider.dart';

class QuestionIndicatorWidget extends StatelessWidget {
  final int currentPage;
  final int pagesLenght;

  const QuestionIndicatorWidget({
    Key? key,
    required this.currentPage,
    required this.pagesLenght,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pregunta $currentPage",
                style: AppTextStyles.body.copyWith(
                  color: settingsController.currentAppTheme.primaryColor,
                ),
              ),
              Text(
                "de $pagesLenght",
                style: AppTextStyles.body.copyWith(
                  color: settingsController.currentAppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ProgressIndicatorWidget(
            value: currentPage / pagesLenght,
          )
        ],
      ),
    );
  }
}
