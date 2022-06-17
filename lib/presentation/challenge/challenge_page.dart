import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/data/models/pregunta_model.dart';
import 'package:educational_quiz_app/data/models/question_model.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
import 'package:educational_quiz_app/presentation/challenge/challenge_controller.dart';
import 'package:educational_quiz_app/presentation/challenge/widgets/next_button/next_button_widget.dart';
import 'package:educational_quiz_app/presentation/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:educational_quiz_app/presentation/challenge/widgets/quiz/quiz_widget.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChallengePage extends StatefulWidget {
  final List<Pregunta> preguntas;
  final String quizTitle;

  const ChallengePage(
      {Key? key, required this.preguntas, required this.quizTitle})
      : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  void nextPage() {
    if (controller.currentPage < widget.preguntas.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  void onSelected(bool isRight) {
    if (isRight) {
      controller.qtdRightAnswers++;
    }
    nextPage();
  }

  @override
  void initState() {
    pageController.addListener(
      () {
        controller.currentPage = pageController.page!.toInt() + 1;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Scaffold(
      backgroundColor:
          settingsController.currentAppTheme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(102),
        child: SafeArea(
          //utilizado para que o conteudo da appbar nao fique por baixo da barra de bateria
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(
                color: settingsController.currentAppTheme.primaryColor,
              ),
              // o value listenable vai fazer o rebuild so nesse componente quando houver atualizacoes
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  pagesLenght: widget.preguntas.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.preguntas
            .map(
              (pregunta) => QuizWidget(
                pregunta: pregunta,
                onAnswerSelected: (valueIsRight) {
                  onSelected(valueIsRight);
                },
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        // para evitar que os botoes inferiores do dispositivo fiquem por cima
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: ValueListenableBuilder(
            valueListenable: controller.currentPageNotifier,
            builder: (context, int value, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (value < widget.preguntas.length)
                  Expanded(
                    child: NextButtonWidget.white(
                      label: "Saltar pregunta",
                      onTap: nextPage,
                    ),
                  ),
                if (value == widget.preguntas.length)
                  const SizedBox(
                    width: 7,
                  ),
                if (value == widget.preguntas.length)
                  Expanded(
                    child: NextButtonWidget.green(
                      label: "Terminar",
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.resultRoute,
                          arguments: ResultPageArgs(
                            quizTitle: widget.quizTitle,
                            questionsLenght: widget.preguntas.length,
                            result: controller.qtdRightAnswers,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
