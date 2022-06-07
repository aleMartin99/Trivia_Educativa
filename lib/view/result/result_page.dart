import 'package:educational_quiz_app/view/challenge/widgets/next_button/next_button_widget.dart';
import 'package:educational_quiz_app/view/settings/settings_controller.dart';
import 'package:flutter/material.dart';

import 'package:educational_quiz_app/core/app_images.dart';
import 'package:educational_quiz_app/core/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ResultPage extends StatelessWidget {
  final String quizTitle;
  final int questionsLenght;
  final int result;

  const ResultPage({
    Key? key,
    required this.quizTitle,
    required this.questionsLenght,
    required this.result,
  }) : super(key: key);

  double get percentage => this.result / this.questionsLenght;

  String get resultImage => this.percentage < 0.5
      ? AppImages.badResult
      : ((percentage < 1 && percentage > 0.5)
          ? AppImages.mediumResult
          : AppImages.trophy);

  String get title => this.percentage < 0.5
      ? "Que triste!"
      : ((percentage < 1 && percentage > 0.5)
          ? "Continua asi!"
          : "Felicidades!");

  String get subtitle => percentage < 0.5
      ? "Acertaste $result de $questionsLenght preguntas. Inténtalo de nuevo para hacerlo mejor"
      : ((percentage < 1 && percentage > 0.5)
          ? "Acertaste $result de $questionsLenght preguntas. Sigue intentándolo!"
          : "Acertaste $result de $questionsLenght preguntas! Excelente!!");

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Scaffold(
      backgroundColor:
          settingsController.currentAppTheme.scaffoldBackgroundColor,
      body: Container(
        width: double.maxFinite, //o maximo possivel
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
                          onTap: () {
                            //podemos usar o pop pq foi substituido do quiz para o resultado
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
