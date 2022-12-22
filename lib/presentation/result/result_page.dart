import 'dart:core';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:trivia_educativa/core/app_sounds.dart';

import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';

import '../../core/theme/text_theme.dart';
import '../../main.dart';
import '../home/home_imports.dart';
import '/../core/core.dart';

import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:confetti/confetti.dart';

// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  final String quizTitle;
  final int questionsLenght;
  final int result;
  final int notaValor;
  final bool isConnected;

  ResultPage(
      {Key? key,
      required this.quizTitle,
      required this.questionsLenght,
      required this.result,
      required this.notaValor,
      required this.isConnected})
      : super(
          key: key,
        );

  late double percent;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final controller = HomeController();
  late ConfettiController _confettiController;
  AudioPlayer player = AudioPlayer();

  Future loadResultSound() async {
    await player.play(
      (AssetSource((widget.notaValor == 2)
          ? AppSounds.randomResultSoundNota2()
          : (widget.notaValor == 3)
              ? AppSounds.randomResultSoundNota3()
              : (widget.notaValor == 4)
                  ? AppSounds.nota4_1
                  : AppSounds.randomResultSoundNota5())),
    );

    player.setReleaseMode(ReleaseMode.release);
    await AudioPlayer.global.changeLogLevel(LogLevel.info);
  }

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
    loadResultSound();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  String get resultImage => widget.notaValor == 2
      ? AppImages.badResult
      : ((widget.notaValor == 3 || widget.notaValor == 4)
          ? AppImages.mediumResult
          : ((widget.notaValor == 5) ? AppImages.trophy : AppImages.error));

  @override
  Widget build(BuildContext context) {
    String title = widget.notaValor == 2
        ? "${I10n.of(context).score_title} 2. \n${I10n.of(context).score_Sad}!"
        : ((widget.notaValor == 3)
            ? "${I10n.of(context).score_title} 3. \n${I10n.of(context).score_Passed}!"
            : ((widget.notaValor == 4)
                ? "${I10n.of(context).score_title} 4. \n${I10n.of(context).score_VeryGood}!"
                : ((widget.notaValor == 5)
                    ? "${I10n.of(context).score_title} 5. \n${I10n.of(context).score_Congrats}!"
                    : '')));

    String subtitle = widget.notaValor == 2
        ? "${I10n.of(context).youGot} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions}. \n${I10n.of(context).score_tip_tryHarder}!"
        : ((widget.notaValor == 3 || widget.notaValor == 4)
            ? "${I10n.of(context).youGot} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions}. \n${I10n.of(context).score_tip_keepWorking}!"
            : ((widget.notaValor == 5)
                ? "${I10n.of(context).youGot} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions}. \n${I10n.of(context).score_tip_excellent}!!"
                : ''));

    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: (title.contains(I10n.of(context).score_Congrats))
              ? Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality
                            .explosive, // don't specify a direction, blast randomly
                        shouldLoop:
                            true, // start again as soon as the animation is finished
                        colors: AppColors.confettiColors,
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(top: height * 12.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            resultImage,
                            width: width * 80,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.heading40.copyWith(
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color,
                                    fontSize: 38),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: height * 1.25),
                                child: Text(
                                  subtitle,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.regularText16.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 10),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 5, right: width * 5),
                                  child: NextButtonWidget.purple(
                                    label: I10n.of(context).share,
                                    onTap: () {
                                      Share.share(
                                          "${I10n.of(context).i_got} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions} ${I10n.of(context).in_} ${widget.quizTitle} ${I10n.of(context).in_} ${I10n.of(context).the_app} ${I10n.of(context).appTitle}. ${I10n.of(context).linkToDownloadBody}");
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 2,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 10),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: height * 1,
                                      left: width * 5,
                                      right: width * 5),
                                  child: NextButtonWidget.transparent(
                                    label: I10n.of(context).backTo_Home,
                                    fontColor: Theme.of(context).hintColor,
                                    onTap: () async {
                                      (widget.isConnected == true)
                                          ? Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                              AppRoutes.homeScreen,
                                              (Route<dynamic> route) => false,
                                            )
                                          : QuickAlert.show(
                                              onConfirmBtnTap: () async {
                                                await sl.popScope();
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        AppRoutes.loginRoute,
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              },
                                              context: context,
                                              type: QuickAlertType.warning,
                                              barrierDismissible: false,
                                              title: I10n.of(context)
                                                  .noInternetConnectionTitle,
                                              confirmBtnText:
                                                  I10n.of(context).ok,
                                              text: I10n.of(context)
                                                  .scoreDialogNoInternet,
                                              backgroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              textColor: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color!,
                                              titleColor: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color!,
                                              confirmBtnColor: AppColors.purple,
                                            );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: height * 12.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        resultImage,
                        width: width * 80,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading40.copyWith(
                                color: Theme.of(context).primaryIconTheme.color,
                                fontSize: 38),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: height * 1.25),
                            child: Text(
                              subtitle,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.regularText16.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 10),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: width * 5, right: width * 5),
                              child: NextButtonWidget.purple(
                                label: I10n.of(context).share,
                                onTap: () {
                                  Share.share(
                                      "${I10n.of(context).i_got} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions} ${I10n.of(context).in_} ${widget.quizTitle} ${I10n.of(context).in_} ${I10n.of(context).the_app} ${I10n.of(context).appTitle}. ${I10n.of(context).linkToDownloadBody}");
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 2,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 10),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: height * 1,
                                  left: width * 5,
                                  right: width * 5),
                              child: NextButtonWidget.transparent(
                                label: I10n.of(context).backTo_Home,
                                fontColor: Theme.of(context).hintColor,
                                onTap: () async {
                                  (widget.isConnected == true)
                                      ? Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                          AppRoutes.homeScreen,
                                          (Route<dynamic> route) => false,
                                        )
                                      : QuickAlert.show(
                                          onConfirmBtnTap: () async {
                                            await sl.popScope();
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    AppRoutes.loginRoute,
                                                    (Route<dynamic> route) =>
                                                        false);
                                          },
                                          context: context,
                                          type: QuickAlertType.warning,
                                          barrierDismissible: false,
                                          title: I10n.of(context)
                                              .noInternetConnectionTitle,
                                          confirmBtnText: I10n.of(context).ok,
                                          text: I10n.of(context)
                                              .scoreDialogNoInternet,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          textColor: Theme.of(context)
                                              .primaryIconTheme
                                              .color!,
                                          titleColor: Theme.of(context)
                                              .primaryIconTheme
                                              .color!,
                                          confirmBtnColor: AppColors.purple,
                                        );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
    );
  }
}
