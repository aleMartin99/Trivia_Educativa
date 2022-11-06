import 'package:flutter/material.dart';

import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import '../home/home_imports.dart';
import '/../core/core.dart';

import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultPage extends StatelessWidget {
  final String quizTitle;
  final int questionsLenght;
  final int result;
  final int rango3;
  final int rango4;
  final int rango5;
  final int puntos;

  ResultPage({
    Key? key,
    required this.quizTitle,
    required this.questionsLenght,
    required this.result,
    required this.rango3,
    required this.rango4,
    required this.rango5,
    required this.puntos,
  }) : super(key: key);

  final controller = HomeController();

//TODO change points system to amount of questions

//* 5 => notaParametro(%)
//*4 => notaParametro - 10%
//*3 => notaParametro - 20%

//TODO change points system to amount of questions
  String get resultImage => puntos < rango3
      ? AppImages.badResult
      : ((puntos >= rango3 && puntos < rango4)
          ? AppImages.mediumResult
          : ((puntos >= rango4 && puntos < rango5)
              ? AppImages.mediumResult
              : ((puntos >= rango5) ? AppImages.trophy : AppImages.error)));

//TODO change points system to amount of questions
  @override
  Widget build(BuildContext context) {
    String title = puntos < rango3
        ? "${I10n.of(context).score_title} 2. \n${I10n.of(context).score_Sad}!"
        : ((puntos >= rango3 && puntos < rango4)
            ? "${I10n.of(context).score_title} 3. \n${I10n.of(context).score_Passed}!"
            : ((puntos >= rango4 && puntos < rango5)
                ? "${I10n.of(context).score_title} 4. \n${I10n.of(context).score_VeryGood}!"
                : ((puntos >= rango5)
                    ? "${I10n.of(context).score_title} 5. \n${I10n.of(context).score_Congrats}!"
                    : '')));
//TODO change points system to amount of questions
    String subtitle = puntos < rango3
        ? "${I10n.of(context).youGot} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions}. ${I10n.of(context).score_tip_tryHarder}!"
        : ((puntos >= rango3 && puntos < rango5)
            ? "${I10n.of(context).youGot} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions}. ${I10n.of(context).score_tip_keepWorking}!"
            : ((puntos >= rango5)
                ? "${I10n.of(context).youGot} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions}. ${I10n.of(context).score_tip_excellent}!!"
                : ''));

    // //*Logs for debuging the code
    // log('puntos ' + puntos.toString());
    // log('rango 3 ' + rango3.toString());
    // log('rango 4 ' + rango4.toString());
    //log('nota 5 ' + nota5.toString());

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
                children: [
                  Text(title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4
                      //  color: settingsController.currentAppTheme.primaryColor,

                      ),
                  Container(
                    width: 189,
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 68.0),
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
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 68.0),
                          child: NextButtonWidget.transparent(
                            label: I10n.of(context).backTo_Home,
                            onTap: () async {
                              //*elimina el stack de vistas 1 a 1 hasta la vista home
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
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
