import 'dart:developer';

import 'package:trivia_educativa/presentation/challenge/widgets/next_button/next_button_widget.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:trivia_educativa/presentation/home/home_controller.dart';
import 'package:trivia_educativa/core/app_images.dart';
import 'package:trivia_educativa/core/app_text_styles.dart';
import 'package:provider/provider.dart';
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
  final String idAsignatura;
  final String idCurso;
  final String idTema;
  final String idNivel;

  ResultPage(
      {Key? key,
      required this.quizTitle,
      required this.questionsLenght,
      required this.result,
      required this.rango3,
      required this.rango4,
      required this.rango5,
      required this.puntos,
      required this.idTema,
      required this.idAsignatura,
      required this.idCurso,
      required this.idNivel})
      : super(key: key);

  final controller = HomeController();

  String get resultImage => puntos < rango3
      ? AppImages.badResult
      : ((puntos >= rango3 && puntos < rango4)
          ? AppImages.mediumResult
          : ((puntos >= rango4 && puntos < rango5)
              ? AppImages.mediumResult
              : ((puntos >= rango5) ? AppImages.trophy : AppImages.error)));

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

    String subtitle = puntos < rango3
        ? "${I10n.of(context).youGot} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions}. ${I10n.of(context).score_tip_tryHarder}!"
        : ((puntos >= rango3 && puntos < rango5)
            ? "${I10n.of(context).youGot} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions}. ${I10n.of(context).score_tip_keepWorking}!"
            : ((puntos >= rango5)
                ? "${I10n.of(context).youGot} $result ${I10n.of(context).of_} $questionsLenght ${I10n.of(context).questions}. ${I10n.of(context).score_tip_excellent}!!"
                : ''));

    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    //*Logs for debuging the code
    log('puntos ' + puntos.toString());
    log('rango 3 ' + rango3.toString());
    log('rango 4 ' + rango4.toString());
    log('rango 5 ' + rango5.toString());

    return Scaffold(
      backgroundColor:
          settingsController.currentAppTheme.scaffoldBackgroundColor,
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
                Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading40.copyWith(
                    color: settingsController.currentAppTheme.primaryColor,
                  ),
                ),
                Container(
                  width: 189,
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: settingsController.currentAppTheme.primaryColor,
                    ),
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
                          label: "${I10n.of(context).share} ",
                          onTap: () {
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
                          label: I10n.of(context).backTo_Tests,
                          onTap: () async {
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
    );
  }
}
