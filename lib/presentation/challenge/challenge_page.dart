import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:quickalert/quickalert.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';

import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallengePage extends StatefulWidget {
  final List<Pregunta> preguntas;
  final String quizTitle;

  final int nota5;
  final String idAsignatura;
  final String idEstudiante;
  final String idTema;
  final String idNivel;

  const ChallengePage(
      {Key? key,
      required this.preguntas,
      required this.quizTitle,
      required this.nota5,
      required this.idTema,
      required this.idAsignatura,
      required this.idEstudiante,
      required this.idNivel})
      : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();
  // final homeController = HomeController();

  bool isPlaying = false;

  void nextPage() {
    if (controller.currentPage < widget.preguntas.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  void onSelected(
    bool isRight,
  ) {
    if (isRight) {
      controller.cantRightAnswers++;
      log('contador de cantidad de preguntas correctas ' +
          controller.cantRightAnswers.toString());
    }
    nextPage();
  }

//TODO make nota3 y nota4 automatic from nota5 (substracting 10)

  int evaluarNivel(int cantPreguntas, int cantRightAnswers, int nota5) {
    int nota = 2;
    int nota3 = nota5 - 20;
    int nota4 = nota5 - 10;
    double percent = cantRightAnswers * 100 / cantPreguntas;

    if (percent >= nota3 && percent < nota4) {
      nota = 3;
    } else if (percent >= nota4 && percent < nota5) {
      nota = 4;
    }
    if (percent >= nota5) {
      nota = 5;
    }
    return nota;
  }

  @override
  void initState() {
    //TODO add challengecontroller listener
    //Todo implement quick dialog
    pageController.addListener(
      () {
        controller.currentPage = pageController.page!.toInt() + 1;
      },
    );
    widget.preguntas.shuffle();
    super.initState();
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(
                        onPressed: () async {
                          QuickAlert.show(
                            onConfirmBtnTap: () async {
                              int nota = evaluarNivel(widget.preguntas.length,
                                  controller.cantRightAnswers, widget.nota5);
                              log('la nota evaluada es' + nota.toString());

                              //*crearNota devuelve el id de la nota creada
                              //*asignarNota asigna esa nota a bd
                              controller.asignarNota(
                                  await controller.crearNota(nota),
                                  widget.idAsignatura,
                                  widget.idTema,
                                  widget.idNivel,
                                  widget.idEstudiante);
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.resultRoute,
                                arguments: ResultPageArgs(
                                  quizTitle: widget.quizTitle,
                                  questionsLenght: widget.preguntas.length,
                                  result: controller.cantRightAnswers,
                                  nota5: widget.nota5,
                                ),
                              );
                            },
                            context: context,
                            type: QuickAlertType.warning,
                            title: I10n.of(context).exitDialog,
                            text: I10n.of(context).exitChallenge,
                            confirmBtnText: 'Aceptar',
                            cancelBtnText: 'Cancelar',
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            textColor:
                                Theme.of(context).primaryIconTheme.color!,
                            titleColor:
                                Theme.of(context).primaryIconTheme.color!,
                            confirmBtnColor: AppColors.purple,
                            showCancelBtn: true,
                          );
                        },
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      IconButton(
                          isSelected: isPlaying,
                          onPressed: () {
                            isPlaying = !isPlaying;
                            setState(() {});
                          },
                          icon: isPlaying
                              ? Icon(
                                  Icons.volume_off,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                )
                              : Icon(
                                  Icons.volume_up,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ))
                    ],
                  ),
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
                    onSelected(
                      valueIsRight,
                    );
                  },
                ),
              )
              .toList(),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: ValueListenableBuilder(
              valueListenable: controller.currentPageNotifier,
              builder: (context, int value, _) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 20, right: 20),
                  child: (value == widget.preguntas.length)
                      ? NextButtonWidget.green(
                          label: I10n.of(context).finish,
                          onTap: () async {
                            int nota = evaluarNivel(widget.preguntas.length,
                                controller.cantRightAnswers, widget.nota5);
                            log('la nota evaluada es' + nota.toString());

                            //*crearNota devuelve el id de la nota creada
                            //*asignarNota asigna esa nota a bd
                            controller.asignarNota(
                                await controller.crearNota(nota),
                                widget.idAsignatura,
                                widget.idTema,
                                widget.idNivel,
                                widget.idEstudiante);
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.resultRoute,
                              arguments: ResultPageArgs(
                                quizTitle: widget.quizTitle,
                                questionsLenght: widget.preguntas.length,
                                result: controller.cantRightAnswers,
                                nota5: widget.nota5,
                              ),
                            );
                          },
                        )
                      : (value < widget.preguntas.length)
                          ? NextButtonWidget.transparent(
                              label: I10n.of(context).skipQuestion,
                              onTap: nextPage,
                            )
                          : const Text('')),
            ),
          ),
        ),
      ),
    );
  }
}
