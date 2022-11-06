import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:provider/provider.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import 'package:trivia_educativa/presentation/settings/settings_imports.dart';
import '../home/home_imports.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallengePage extends StatefulWidget {
  final List<Pregunta> preguntas;
  final String quizTitle;
  final int rango3;
  final int rango4;
  final int rango5;
  final String idAsignatura;

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
      controller.cantRightAnswers++;
      log('contador de cantidad de preguntas correctas ' +
          controller.cantRightAnswers.toString());
      //TODO quitar puntos
      controller.puntos += puntaje;
      log('contador de cantidad de puntos ' + controller.puntos.toString());
    }
    nextPage();
  }

//TODO change evaluar to por ciento

//TODO make nota3 y nota4 automatic from nota5 (substracting 10)

  // int evaluarNivel(int cantPreguntas, int cantRightAnswers, int nota5) {
  //   int nota = 2;
  //   int nota3 = nota5 - 20;
  //   int nota4 = nota5 - 10;
  //   double percent = cantRightAnswers * 100 / cantPreguntas;

  //   if (percent >= nota3 && percent < nota4) {
  //     nota = 3;
  //   } else if (percent >= nota4 && percent < nota5) {
  //     nota = 4;
  //   }
  //   if (percent >= nota5) {
  //     nota = 5;
  //   }
  //   return nota;
  // }
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
        //TODO change to new evaluarnivel
        int nota = evaluarNivel(
            controller.puntos, widget.rango3, widget.rango4, widget.rango5);
        log(nota.toString());
        controller.crearNota(nota);
        await controller.getNotasProv();

        //*se asigna la nota
        //PutAsignar
//TODO Add idEstudiante
        await controller.asignarNota(widget.idAsignatura, widget.idTema,
            widget.idNivel, controller.notasProv!.last.id);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.resultRoute,
          arguments: ResultPageArgs(
            quizTitle: widget.quizTitle,
            questionsLenght: widget.preguntas.length,
            result: controller.cantRightAnswers,
            //TODO remove rangos-puntos and add nota5
            rango3: widget.rango3,
            rango4: widget.rango4,
            rango5: widget.rango5,
            puntos: controller.puntos,
          ),
        );
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(I10n.of(context).exitDialog,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: AppTextStyles.heading.copyWith(
            color: settingsController.currentAppTheme.primaryColor,
          )),
      content: Text(
        I10n.of(context).exitChallenge,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
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
    double deviceHeight = MediaQuery.of(context).size.height / 100;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(deviceHeight * 15),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(
                  onPressed: () async {
                    const _acceptText = 'Aceptar';
                    const _declineText = 'Cancelar';
                    final _result = await Dialoger.showTwoChoicesDialog(
                      acceptText: _acceptText,
                      declineText: _declineText,
                      context: context,
                      title: I10n.of(context).exitDialog,
                      description: I10n.of(context).exitChallenge,
                    );
                    if (_result == _acceptText) {
                      int nota = evaluarNivel(controller.puntos, widget.rango3,
                          widget.rango4, widget.rango5);
                      log(nota.toString());
                      controller.crearNota(nota);
                      await controller.getNotasProv();
                      //*se asigna la nota
                      //*PutAsignar
                      await controller.asignarNota(
                          widget.idAsignatura,
                          widget.idTema,
                          widget.idNivel,
                          controller.notasProv!.last.id);
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.resultRoute,
                        arguments: ResultPageArgs(
                          quizTitle: widget.quizTitle,
                          questionsLenght: widget.preguntas.length,
                          result: controller.cantRightAnswers,
                          rango3: widget.rango3,
                          rango4: widget.rango4,
                          rango5: widget.rango5,
                          puntos: controller.puntos,
                        ),
                      );
                    }
                    // showAlertDialog(context);
                  },
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                //the ValueListenableBuilder will only rebuild this component when there are updates
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: controller.currentPageNotifier,
                    builder: (context, value, _) => QuestionIndicatorWidget(
                      currentPage: value,
                      pagesLenght: widget.preguntas.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          //TODO Check this property in case the question content is to big and there is need to scroll
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
                          controller.crearNota(nota);
                          await controller.getNotasProv();
                          //*se asigna la nota
                          //*PutAsignar
                          await controller.asignarNota(
                              //TODO add idEstudiante
                              widget.idAsignatura,
                              widget.idTema,
                              widget.idNivel,
                              controller.notasProv!.last.id);
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.resultRoute,
                            arguments: ResultPageArgs(
                              quizTitle: widget.quizTitle,
                              questionsLenght: widget.preguntas.length,
                              result: controller.cantRightAnswers,
                              rango3: widget.rango3,
                              rango4: widget.rango4,
                              rango5: widget.rango5,
                              puntos: controller.puntos,
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
      ),
    );
  }
}
