import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:trivia_educativa/presentation/shared/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                "${I10n.of(context).question} $currentPage",
                style: AppTextStyles.body.copyWith(
                  color: settingsController.currentAppTheme.primaryColor,
                ),
              ),
              Text(
                "${I10n.of(context).of_} $pagesLenght",
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
