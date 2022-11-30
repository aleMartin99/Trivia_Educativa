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
