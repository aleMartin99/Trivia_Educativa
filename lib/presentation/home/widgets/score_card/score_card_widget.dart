import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';
import '../../../../core/theme/text_theme.dart';
import '../../home_imports.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScoreCardWidget extends StatelessWidget {
  const ScoreCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return Padding(
      padding: EdgeInsets.only(
        left: width * 5,
        right: width * 5,
      ),
      child: Container(
        height: height * 16.95,
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
          padding: EdgeInsets.symmetric(horizontal: width * 5.7),
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: ChartWidget(),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: width * 5.7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        I10n.of(context).passedTests,
                        style: AppTextStyles.titleBold.copyWith(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryIconTheme.color),
                      ),
                      Text(
                        I10n.of(context).improveScore,
                        style: AppTextStyles.regularText16,
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
