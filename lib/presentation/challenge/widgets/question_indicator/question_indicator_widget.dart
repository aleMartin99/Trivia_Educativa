import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trivia_educativa/core/theme/text_theme.dart';
import 'package:trivia_educativa/presentation/shared/shared_imports.dart';

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
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 5),
      child: Column(
        children: [
          SizedBox(
            height: height * 2.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${I10n.of(context).questioN} $currentPage",
                style: AppTextStyles.regularText16.copyWith(
                  fontSize: 14,
                ),
              ),
              Text(
                "${I10n.of(context).of_} $pagesLenght",
                style: AppTextStyles.regularText16.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 2.1,
          ),
          ProgressIndicatorWidget(
            value: currentPage / pagesLenght,
          )
        ],
      ),
    );
  }
}
