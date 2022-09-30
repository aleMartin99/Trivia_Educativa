import 'package:trivia_educativa/core/app_theme.dart';
import 'package:trivia_educativa/presentation/home/widgets/chart/chart_widget.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:provider/provider.dart';

class ScoreCardWidget extends StatelessWidget {
  final double scorePercentage;

  const ScoreCardWidget({
    Key? key,
    required this.scorePercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        // top: 14,
      ),
      child: Container(
        height: 136,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.backgroundColors(
              settingsController.currentAppTheme.brightness),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: AppColors.lightGrey,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ChartWidget(
                  percent: scorePercentage,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        I10n.of(context).passedTests,
                        style: AppTextStyles.heading.copyWith(
                          color:
                              settingsController.currentAppTheme.primaryColor,
                        ),
                      ),
                      Text(
                        I10n.of(context).improveScore,
                        style: AppTextStyles.body.copyWith(
                          color:
                              settingsController.currentAppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
