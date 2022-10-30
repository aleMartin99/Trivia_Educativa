import 'package:trivia_educativa/core/app_theme.dart';
import 'package:trivia_educativa/presentation/home/widgets/chart/chart_widget.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:provider/provider.dart';

class ScoreCardWidget extends StatelessWidget {
  const ScoreCardWidget({
    Key? key,
    //required this.scorePercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          color: AppTheme.backgroundColors(Theme.of(context).brightness),
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
              const Expanded(
                flex: 1,
                child: ChartWidget(
                    // percent: scorePercentage,
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
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize:
                                21, //color: settingsController.currentAppTheme.primaryColor,
                            color: Theme.of(context).primaryIconTheme.color),
                      ),
                      Text(
                        I10n.of(context).improveScore,
                        //TODO make this body text style
                        style: TextStyle(
                            fontFamily: 'PNRegular',
                            fontSize: 14,
                            color: Theme.of(context).primaryIconTheme.color
                            // fontWeight: FontWeight.w100,
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
