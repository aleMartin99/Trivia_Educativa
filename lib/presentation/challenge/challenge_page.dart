// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:core';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';

import 'dart:developer';

import 'package:quickalert/quickalert.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:trivia_educativa/core/network_info/network_info.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';

import '../../data/models/auth_model.dart';
import '../../data/models/nota_local_model.dart';
import '../../domain/repositories/nota_repository.dart';
import '../../main.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallengePage extends StatefulWidget {
  final List<Pregunta> preguntas;
  final String quizTitle;
  final int nota5;
  final Asignatura asignatura;
  final String idEstudiante;
  final String idTema;
  final Nivel nivel;

  ChallengePage({
    Key? key,
    required this.preguntas,
    required this.quizTitle,
    required this.nota5,
    required this.idTema,
    required this.asignatura,
    required this.idEstudiante,
    required this.nivel,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();
  late final StreamDuration _streamDuration;

  bool isConnected = true;
  var auth = sl<Auth>();
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  late int notaValor;
  @override
  void dispose() {
    player.dispose();
    _streamDuration.dispose();
    super.dispose();
  }

  Future loadMusic() async {
    if (widget.asignatura.networkAudio) {
      String url = widget.asignatura.soundtrack;
      log(url);
      await player.setSourceUrl(url);
      await player.resume();
    } else {
      await player.play(
        (AssetSource(widget.asignatura.soundtrack)),
      );
    }
    player.setReleaseMode(ReleaseMode.loop);
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
    }
    nextPage();
  }

  Future saveNota() async {
    notaValor = evaluarNivel(
        widget.preguntas.length, controller.cantRightAnswers, widget.nota5);
    var networkInfo = sl<NetworkInfo>();
    if (await networkInfo.isConnected) {
      //*crearNota devuelve el id de la nota creada
      //*asignarNota asigna esa nota a bd
      await controller.asignarNota(
          await controller.crearNota(notaValor, auth.token),
          widget.asignatura.id,
          widget.idTema,
          widget.nivel.id,
          widget.idEstudiante,
          auth.token);
    } else {
      controller.state = ChallengeState.loading;
      var db = sl<NotaRepository>();
      NotaLocal nota = NotaLocal(
          idAsignatura: widget.asignatura.id,
          idEstudiante: widget.idEstudiante,
          idNivel: widget.nivel.id,
          idTema: widget.idTema,
          nota: notaValor);
      await db.addNota(nota);
      isConnected = false;
    }
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
          //TODO fix quick alert dialog and make a package
         // onWillPop: false,
          onConfirmBtnTap: () async {
            await player.release();
            await saveNota();
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.resultRoute,
              arguments: ResultPageArgs(
                notaValor: notaValor,
                isConnected: isConnected,
                quizTitle: widget.quizTitle,
                questionsLenght: widget.preguntas.length,
                result: controller.cantRightAnswers,
              ),
            );
          },
          context: context,
          barrierDismissible: false,
          type: QuickAlertType.info,
          title: I10n.of(context).timeoutDialogTitle,
          text: I10n.of(context).timeoutDialogBody,
          confirmBtnText: I10n.of(context).ok,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );
      }

      if (controller.state == ChallengeState.serverUnreachable) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        QuickAlert.show(
          context: context,
          barrierDismissible: false,
          type: QuickAlertType.info,
          title: I10n.of(context).serverUnavailableTitle,
          confirmBtnText: I10n.of(context).ok,
          text: I10n.of(context).serverUnavailableBody,
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
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 15),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 2.45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(
                        onPressed: () async {
                          QuickAlert.show(
                            onConfirmBtnTap: () async {
                              _streamDuration.pause();
                              await player.release();

                              await saveNota();
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.resultRoute,
                                arguments: ResultPageArgs(
                                  notaValor: notaValor,
                                  isConnected: isConnected,
                                  quizTitle: widget.quizTitle,
                                  questionsLenght: widget.preguntas.length,
                                  result: controller.cantRightAnswers,
                                ),
                              );
                            },
                            context: context,
                            type: QuickAlertType.warning,
                            title: I10n.of(context).exitDialog,
                            text: I10n.of(context).exitChallenge,
                            confirmBtnText: I10n.of(context).ok,
                            cancelBtnText: I10n.of(context).cancel,
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
                        icon: Padding(
                          padding: EdgeInsets.only(right: width * 1.9),
                          child: Icon(
                            Icons.timer,
                            size: 20,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        decoration: const BoxDecoration(
                            color: AppColors.purple,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        duration: Duration(minutes: widget.nivel.duracion),
                        onDone: () => controller.state = ChallengeState.timeOut,
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
            padding: EdgeInsets.symmetric(
              horizontal: width * 10,
              vertical: height * 2.5,
            ),
            child: ValueListenableBuilder(
              valueListenable: controller.currentPageNotifier,
              builder: (context, int value, _) => Padding(
                  padding: EdgeInsets.only(
                      bottom: height * 1, left: width * 5, right: width * 5),
                  child: ValueListenableBuilder<ChallengeState>(
                      valueListenable: controller.stateNotifier,
                      builder: (ctx, loadingValue, _) => (loadingValue ==
                              ChallengeState.evaluating)
                          ? SizedBox(
                              height: height * 6,
                              child: const Center(
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
                                    await saveNota();

                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.resultRoute,
                                      arguments: ResultPageArgs(
                                        notaValor: notaValor,
                                        isConnected: isConnected,
                                        quizTitle: widget.quizTitle,
                                        questionsLenght:
                                            widget.preguntas.length,
                                        result: controller.cantRightAnswers,
                                      ),
                                    );
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
