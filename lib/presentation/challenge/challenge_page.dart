import 'dart:core';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';

import 'dart:developer';

import 'package:quickalert/quickalert.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';

import '../../data/models/auth_model.dart';
import '../../main.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallengePage extends StatefulWidget {
  final List<Pregunta> preguntas;
  final String quizTitle;
  final int nota5;
  final String idAsignatura;
  final String idEstudiante;
  final String idTema;
  final Nivel nivel;

  const ChallengePage(
      {Key? key,
      required this.preguntas,
      required this.quizTitle,
      required this.nota5,
      required this.idTema,
      required this.idAsignatura,
      required this.idEstudiante,
      required this.nivel})
      : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();
  late final StreamDuration _streamDuration;
  AudioPlayer player = AudioPlayer();
  var auth = sl<Auth>();

  bool isPlaying = false;

  @override
  void dispose() {
    player.dispose();
    _streamDuration.dispose();
    super.dispose();
  }

  Future loadMusic() async {
    //TODO change to url if doesn't work
    //todo Audio carga aqui de asignatura.audio
    await player.play(
      (AssetSource('audios/soundtrack_1.mp3')),
    );

    player.setReleaseMode(ReleaseMode.loop);
    // advancedPlayer = await AudioCache().loop("music/song3.mp3");
    await AudioPlayer.global.changeLogLevel(LogLevel.info);
  }

  void nextPage() {
    if (controller.currentPage < widget.preguntas.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
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

  int evaluarNivel(int cantPreguntas, int cantRightAnswers, int nota5) {
    int nota = 2;
    int nota3;
    int nota4;
    if (nota5 >= 20) {
      nota3 = nota5 - 20;
    } else {
      nota3 = 0;
    }
    if (nota5 >= 10) {
      nota4 = nota5 - 10;
    } else {
      nota4 = 10;
    }

    double percent = cantRightAnswers * 100 / cantPreguntas;

    if (percent >= nota3 && percent < nota4) {
      nota = 3;
    } else if (percent >= nota4 && percent < nota5) {
      nota = 4;
    }
    if (percent >= nota5) {
      nota = 5;
    }
    log(nota.toString());
    return nota;
  }

  @override
  void initState() {
    _streamDuration = StreamDuration(
      Duration(
        minutes: widget.nivel.duracion,
      ),
      onDone: () => controller.state = ChallengeState.timeOut,
    );

    controller.stateNotifier.addListener(() {
      if (controller.state == ChallengeState.timeOut) {
        QuickAlert.show(
          onConfirmBtnTap: () async {
            await player.release();
            int nota = evaluarNivel(widget.preguntas.length,
                controller.cantRightAnswers, widget.nota5);
            log('la nota evaluada es' + nota.toString());

            //*crearNota devuelve el id de la nota creada
            //*asignarNota asigna esa nota a bd
            await controller.asignarNota(
                await controller.crearNota(nota, auth.token),
                widget.idAsignatura,
                widget.idTema,
                widget.nivel.id,
                widget.idEstudiante,
                auth.token);
            // Navigator.pop(context);
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
          barrierDismissible: false,
          type: QuickAlertType.info,
          title: 'Tiempo agotado',
          text: 'Se ha acabado el tiempo para completar el nivel',
          confirmBtnText: 'Ok',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );
      }

      if (controller.state == ChallengeState.serverError) {
        QuickAlert.show(
          onConfirmBtnTap: () async {
            // await player.release();
            // int nota = evaluarNivel(widget.preguntas.length,
            //     controller.cantRightAnswers, widget.nota5);
            // log('la nota evaluada es' + nota.toString());

            // //*crearNota devuelve el id de la nota creada
            // //*asignarNota asigna esa nota a bd
            // controller.asignarNota(
            //     await controller.crearNota(nota, auth.token),
            //     widget.idAsignatura,
            //     widget.idTema,
            //     widget.nivel.id,
            //     widget.idEstudiante,
            //     auth.token);
            // // Navigator.pop(context);
            // Navigator.pushReplacementNamed(
            //   context,
            //   AppRoutes.resultRoute,
            //   arguments: ResultPageArgs(
            //     quizTitle: widget.quizTitle,
            //     questionsLenght: widget.preguntas.length,
            //     result: controller.cantRightAnswers,
            //     nota5: widget.nota5,
            //   ),
            // );
          },
          //TODO change messages
          context: context,
          barrierDismissible: false,
          type: QuickAlertType.info,
          title: 'Internal server error',
          text: 'Se ha explotado',
          confirmBtnText: 'Ok',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );
        controller.state = ChallengeState.empty;
      }
    });

    pageController.addListener(
      () {
        controller.currentPage = pageController.page!.toInt() + 1;
      },
    );
    loadMusic();
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
                        //TODO check x que si me voy a result page luego sale el timeout
                        onPressed: () async {
                          //TODO si no hay internet guardar local y pa fuera
                          QuickAlert.show(
                            onConfirmBtnTap: () async {
                              _streamDuration.pause();
                              await player.release();
                              int nota = evaluarNivel(widget.preguntas.length,
                                  controller.cantRightAnswers, widget.nota5);
                              log('la nota evaluada es' + nota.toString());

                              //*crearNota devuelve el id de la nota creada
                              //*asignarNota asigna esa nota a bd
                              await controller.asignarNota(
                                  await controller.crearNota(nota, auth.token),
                                  widget.idAsignatura,
                                  widget.idTema,
                                  widget.nivel.id,
                                  widget.idEstudiante,
                                  auth.token);
                              Navigator.pop(context);
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
                      SlideCountdown(
                        streamDuration: _streamDuration,
                        //fade: true,
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.timer,
                            size: 20,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        //showZeroValue: true,
                        decoration: const BoxDecoration(
                            color: AppColors.purple,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        duration: Duration(minutes: widget.nivel.duracion),

                        onDone: () => controller.state = ChallengeState.timeOut,
                        // countUp: true,
                      ),
                      IconButton(
                          isSelected: isPlaying,
                          onPressed: () async {
                            isPlaying
                                ? await player.resume()
                                : await player.pause();
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
                  child: ValueListenableBuilder<ChallengeState>(
                      valueListenable: controller.stateNotifier,
                      builder: (ctx, loadingValue, _) => (loadingValue ==
                              ChallengeState.evaluating)
                          ? const SizedBox(
                              height: 48,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.green,
                                backgroundColor: Colors.black12,
                              )),
                            )
                          : (value == widget.preguntas.length)
                              ? NextButtonWidget.green(
                                  label: I10n.of(context).finish,
                                  onTap: () async {
                                    _streamDuration.pause();
                                    await player.release();
                                    int nota = evaluarNivel(
                                        widget.preguntas.length,
                                        controller.cantRightAnswers,
                                        widget.nota5);
                                    log('la nota evaluada es' +
                                        nota.toString());

                                    //*crearNota devuelve el id de la nota creada
                                    //*asignarNota asigna esa nota a bd
                                    //TODO si no hay internet guardar local y pa fuera
                                    await controller.asignarNota(
                                        await controller.crearNota(
                                            nota, auth.token),
                                        widget.idAsignatura,
                                        widget.idTema,
                                        widget.nivel.id,
                                        widget.idEstudiante,
                                        auth.token);

                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRoutes.resultRoute,
                                        arguments: ResultPageArgs(
                                          quizTitle: widget.quizTitle,
                                          questionsLenght:
                                              widget.preguntas.length,
                                          result: controller.cantRightAnswers,
                                          nota5: widget.nota5,
                                        ),
                                        (Route<dynamic> route) => false);
                                  },
                                )
                              : (value < widget.preguntas.length)
                                  ? NextButtonWidget.transparent(
                                      label: I10n.of(context).skipQuestion,
                                      onTap: nextPage,
                                      fontColor: Theme.of(context).hintColor,
                                    )
                                  : const Text(''))),
            ),
          ),
        ),
      ),
    );
  }
}
