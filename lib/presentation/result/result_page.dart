import 'dart:core';

import 'package:flutter/material.dart';

import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import '../../core/routers/routers.dart';

import '../home/home_imports.dart';
import '/../core/core.dart';

import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultPage extends StatelessWidget {
  final String quizTitle;
  final int questionsLenght;
  final int result;
  final int nota5;

  ResultPage({
    Key? key,
    required this.quizTitle,
    required this.questionsLenght,
    required this.result,
    required this.nota5,
  }) : super(key: key);

  final controller = HomeController();

//TODO change points system to amount of questions

//* 5 => notaParametro(%)
//*4 => notaParametro - 10%
//*3 => notaParametro - 20%

  int get nota3 => nota5 - 20;
  int get nota4 => nota5 - 10;

//TODO change points system to amount of questions
  String get resultImage => result < nota3
      ? AppImages.badResult
      : ((result >= nota3 && result < nota4)
          ? AppImages.mediumResult
          : ((result >= nota4 && result < nota5)
              ? AppImages.mediumResult
              : ((result >= nota5) ? AppImages.trophy : AppImages.error)));

//TODO change points system to amount of questions
  @override
  Widget build(BuildContext context) {
    String title = result < nota3
        ? "${I10n.of(context).score_title} 2. \n${I10n.of(context).score_Sad}!"
        : ((result >= nota3 && result < nota4)
            ? "${I10n.of(context).score_title} 3. \n${I10n.of(context).score_Passed}!"
            : ((result >= nota4 && result < nota5)
                ? "${I10n.of(context).score_title} 4. \n${I10n.of(context).score_VeryGood}!"
                : ((result >= nota5)
                    ? "${I10n.of(context).score_title} 5. \n${I10n.of(context).score_Congrats}!"
                    : '')));

    String subtitle = result < nota3
        ? "${I10n.of(context).youGot} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions}. \n${I10n.of(context).score_tip_tryHarder}!"
        : ((result >= nota3 && result < nota5)
            ? "${I10n.of(context).youGot} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions}. \n${I10n.of(context).score_tip_keepWorking}!"
            : ((result >= nota5)
                ? "${I10n.of(context).youGot} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions}. \n${I10n.of(context).score_tip_excellent}!!"
                : ''));

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                resultImage,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading40.copyWith(
                        color: Theme.of(context).primaryIconTheme.color,
                        fontSize: 38),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'PNRegular',
                          fontSize: 18,
                          color: Theme.of(context).primaryIconTheme.color),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    //TODO check button size
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: .0, left: 20, right: 20),
                      child: NextButtonWidget.purple(
                        //TODO check if share works in physical device
                        label: "${I10n.of(context).share} ",
                        onTap: () {
                          //TODO checkear en telef fisico que funcione sin pedir contactos
                          Share.share(
                              "${I10n.of(context).i_got} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions} ${I10n.of(context).in_} $quizTitle ${I10n.of(context).in_} ${I10n.of(context).the_app} ${I10n.of(context).appTitle}");
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    //TODO check button size
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 20, right: 20),
                      child: NextButtonWidget.transparent(
                        label: I10n.of(context).backTo_Home,
                        onTap: () async {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.homeScreen,
                            arguments: HomeScreenArgs(),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
