import 'dart:developer';

import 'package:trivia_educativa/core/app_routes.dart';
import 'package:trivia_educativa/core/app_text_styles.dart';
import 'package:trivia_educativa/data/models/pregunta_model.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_controller.dart';
import 'package:trivia_educativa/presentation/challenge/widgets/next_button/next_button_widget.dart';
import 'package:trivia_educativa/presentation/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:trivia_educativa/presentation/challenge/widgets/quiz/quiz_widget.dart';
import 'package:trivia_educativa/presentation/home/home_controller.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallengePage extends StatefulWidget {
  final List<Pregunta> preguntas;
  final String quizTitle;
  final int rango3;
  final int rango4;
  final int rango5;
  final String idAsignatura;
  final String idCurso;
  final String idTema;
  final String idNivel;

  const ChallengePage(
      {Key? key,
      required this.preguntas,
      required this.quizTitle,
      required this.rango3,
      required this.rango4,
      required this.rango5,
      required this.idTema,
      required this.idAsignatura,
      required this.idCurso,
      required this.idNivel})
      : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();
  final homeController = HomeController();

  void nextPage() {
    if (controller.currentPage < widget.preguntas.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  void onSelected(bool isRight, int puntaje) {
    if (isRight) {
      controller.qtdRightAnswers++;
      log('contador de cantidad de preguntas correctas ' +
          controller.qtdRightAnswers.toString());
      controller.puntos += puntaje;
      log('contador de cantidad de puntos ' + controller.puntos.toString());
    }
    nextPage();
  }

  int evaluarNivel(int puntos, int rango3, int rango4, int rango5) {
    int nota = 2;
    if (puntos >= rango3 && puntos < rango4) {
      nota = 3;
    } else if (puntos >= rango4 && puntos < rango5) {
      nota = 4;
    }
    if (puntos >= rango5) {
      nota = 5;
    }
    return nota;
  }

  @override
  void initState() {
    pageController.addListener(
      () {
        controller.currentPage = pageController.page!.toInt() + 1;
      },
    );
    widget.preguntas.shuffle();
    super.initState();
  }

  showAlertDialog(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context, listen: false);

    // Create button
    Widget cancelButton = TextButton(
      child: Text(
        I10n.of(context).cancel,
        style: AppTextStyles.heading
            .copyWith(color: settingsController.currentAppTheme.primaryColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: Text(
        I10n.of(context).ok,
        style: AppTextStyles.heading
            .copyWith(color: settingsController.currentAppTheme.primaryColor),
      ),
      onPressed: () async {
        int nota = evaluarNivel(
            controller.puntos, widget.rango3, widget.rango4, widget.rango5);
        log(nota.toString());
        homeController.crearNota(nota);
        await homeController.getNotasProv();

        //*se asigna la nota
        //PutAsignar

        await homeController.asignarNota(widget.idAsignatura, widget.idCurso,
            widget.idTema, widget.idNivel, homeController.notasProv!.last.id);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.resultRoute,
          arguments: ResultPageArgs(
              quizTitle: widget.quizTitle,
              questionsLenght: widget.preguntas.length,
              result: controller.qtdRightAnswers,
              rango3: widget.rango3,
              rango4: widget.rango4,
              rango5: widget.rango5,
              puntos: controller.puntos,
              idAsignatura: widget.idAsignatura,
              idCurso: widget.idCurso,
              idTema: widget.idTema,
              idNivel: widget.idNivel),
        );
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          Text(I10n.of(context).exitDialog,
              style: AppTextStyles.heading.copyWith(
                color: settingsController.currentAppTheme.primaryColor,
              )),
        ],
      ),
      content: Text(
        I10n.of(context).exitChallenge,
        style: AppTextStyles.body.copyWith(
            color: settingsController.currentAppTheme.primaryColor,
            fontSize: 15),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
      actionsAlignment: MainAxisAlignment.center,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor:
            settingsController.currentAppTheme.scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(102),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  color: settingsController.currentAppTheme.primaryColor,
                ),
                //TODO traducir texto
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
                    onSelected(valueIsRight, pregunta.puntos);
                  },
                ),
              )
              .toList(),
        ),
        bottomNavigationBar: SafeArea(
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
                        label: I10n.of(context).skipQuestion,
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
                        label: I10n.of(context).finish,
                        onTap: () async {
                          //*se evalua el resultado del test, creando un entero con la nota

                          //*Se crea el Objeto NotaProv al crear la nota
                          //postCrearNota
                          int nota = evaluarNivel(controller.puntos,
                              widget.rango3, widget.rango4, widget.rango5);
                          log(nota.toString());
                          homeController.crearNota(nota);
                          await homeController.getNotasProv();

                          //*se asigna la nota
                          //PutAsignar

                          await homeController.asignarNota(
                              widget.idAsignatura,
                              widget.idCurso,
                              widget.idTema,
                              widget.idNivel,
                              homeController.notasProv!.last.id);
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.resultRoute,
                            arguments: ResultPageArgs(
                                quizTitle: widget.quizTitle,
                                questionsLenght: widget.preguntas.length,
                                result: controller.qtdRightAnswers,
                                rango3: widget.rango3,
                                rango4: widget.rango4,
                                rango5: widget.rango5,
                                puntos: controller.puntos,
                                idAsignatura: widget.idAsignatura,
                                idCurso: widget.idCurso,
                                idTema: widget.idTema,
                                idNivel: widget.idNivel),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
