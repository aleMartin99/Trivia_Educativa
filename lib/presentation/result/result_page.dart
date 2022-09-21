import 'dart:developer';

import 'package:trivia_educativa/presentation/challenge/widgets/next_button/next_button_widget.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:trivia_educativa/presentation/home/home_controller.dart';
import 'package:trivia_educativa/core/app_images.dart';
import 'package:trivia_educativa/core/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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

  String get title => puntos < rango3
      ? "Tienes 2 puntos. \nQue triste!"
      : ((puntos >= rango3 && puntos < rango4)
          ? "Tienes 3 puntos. \nAprobaste!"
          : ((puntos >= rango4 && puntos < rango5)
              ? "Tienes 4 puntos. \n Muy Bien!"
              : ((puntos >= rango5) ? "Tienes 5 puntos. \nFelicidades!" : '')));

  String get subtitle => puntos < rango3
      ? "Acertaste $result de $questionsLenght preguntas. Debes esforzarte más!"
      : ((puntos >= rango3 && puntos < rango5)
          ? "Acertaste $result de $questionsLenght preguntas. Sigue esforzándote!"
          : ((puntos >= rango5)
              ? "Acertaste $result de $questionsLenght preguntas! Excelente!!"
              : ''));

  @override
  Widget build(BuildContext context) {
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
                          label: "Compartir ",
                          onTap: () {
                            Share.share(
                                "Obtuve $result de $questionsLenght en $quizTitle en la aplicacion Educational Quiz app!");
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
                          label: "Volver al inicio",
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
