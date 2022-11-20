import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import '../../core/network_info/network_info.dart';
import '../../core/routers/routers.dart';

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
  final int nota5;
  final bool isConnected;

  ResultPage(
      {Key? key,
      required this.quizTitle,
      required this.questionsLenght,
      required this.result,
      required this.nota5,
      required this.isConnected})
      : super(
          key: key,
        ) {
    percent = result * 100 / questionsLenght;
  }

  late double percent;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final controller = HomeController();
  //TODO implement sounds for results like 2,3,4,5

  late ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  // Path drawStar(Size size) {
  //   // Method to convert degree to radians
  //   double degToRad(double deg) => deg * (pi / 180.0);

  //   const numberOfPoints = 5;
  //   final halfWidth = size.width / 2;
  //   final externalRadius = halfWidth;
  //   final internalRadius = halfWidth / 2.5;
  //   final degreesPerStep = degToRad(360 / numberOfPoints);
  //   final halfDegreesPerStep = degreesPerStep / 2;
  //   final path = Path();
  //   final fullAngle = degToRad(360);
  //   path.moveTo(size.width, halfWidth);

  //   for (double step = 0; step < fullAngle; step += degreesPerStep) {
  //     path.lineTo(halfWidth + externalRadius * cos(step),
  //         halfWidth + externalRadius * sin(step));
  //     path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
  //         halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  //   }
  //   path.close();
  //   return path;
  // }

  int get nota3 => widget.nota5 - 20;

  int get nota4 => widget.nota5 - 10;

  String get resultImage => widget.percent < nota3
      ? AppImages.badResult
      : ((widget.percent >= nota3 && widget.percent < nota4)
          ? AppImages.mediumResult
          : ((widget.percent >= nota4 && widget.percent < widget.nota5)
              ? AppImages.mediumResult
              : ((widget.percent >= widget.nota5)
                  ? AppImages.trophy
                  : AppImages.error)));

  @override
  Widget build(BuildContext context) {
    String title = widget.percent < nota3
        ? "${I10n.of(context).score_title} 2. \n${I10n.of(context).score_Sad}!"
        : ((widget.percent >= nota3 && widget.percent < nota4)
            ? "${I10n.of(context).score_title} 3. \n${I10n.of(context).score_Passed}!"
            : ((widget.percent >= nota4 && widget.percent < widget.nota5)
                ? "${I10n.of(context).score_title} 4. \n${I10n.of(context).score_VeryGood}!"
                : ((widget.percent >= widget.nota5)
                    ? "${I10n.of(context).score_title} 5. \n${I10n.of(context).score_Congrats}!"
                    : '')));

    String subtitle = widget.percent < nota3
        ? "${I10n.of(context).youGot} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions}. \n${I10n.of(context).score_tip_tryHarder}!"
        : ((widget.percent >= nota3 && widget.percent < widget.nota5)
            ? "${I10n.of(context).youGot} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions}. \n${I10n.of(context).score_tip_keepWorking}!"
            : ((widget.percent >= widget.nota5)
                ? "${I10n.of(context).youGot} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions}. \n${I10n.of(context).score_tip_excellent}!!"
                : ''));

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
                        //blastDirection: pi, // radial value - LEFT
                        blastDirectionality: BlastDirectionality
                            .explosive, // don't specify a direction, blast randomly
                        shouldLoop:
                            true, // start again as soon as the animation is finished
                        colors: const [
                          //TODO pasar para colores const
                          Colors.green,
                          Colors.blue,
                          Colors.pink,
                          Colors.orange,
                          Colors.purple,
                          AppColors.purple
                        ], // manually specify the colors to be used
                        // createParticlePath: drawStar,
                      ),
                    ),
                    Container(
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
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  subtitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'PNRegular',
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: .0, left: 20, right: 20),
                                  child: NextButtonWidget.purple(
                                    label: "${I10n.of(context).share} ",
                                    onTap: () {
                                      //TODO checkear en telef fisico que funcione sin pedir contactos
                                      Share.share(
                                          "${I10n.of(context).i_got} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions} ${I10n.of(context).in_} ${widget.quizTitle} ${I10n.of(context).in_} ${I10n.of(context).the_app} ${I10n.of(context).appTitle}");
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, left: 20, right: 20),
                                  child: NextButtonWidget.transparent(
                                    label: I10n.of(context).backTo_Home,
                                    fontColor: Theme.of(context).hintColor,
                                    onTap: () async {
                                      //  final NetworkInfo _networkInfo = sl();
                                      (widget.isConnected)
                                          ? QuickAlert.show(
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
                                              //TODO I10n
                                              type: QuickAlertType.warning,
                                              barrierDismissible: false,
                                              title:
                                                  'No hay conexión a Internet',
                                              confirmBtnText: 'Aceptar',
                                              //cancelBtnText: 'Cancelar',
                                              text:
                                                  'Su nota ha sido guardada exitosamente. Se le rediccionará al Login',
                                              backgroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              textColor: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color!,
                                              titleColor: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color!,
                                              confirmBtnColor: AppColors.purple,
                                              // showCancelBtn: true,

                                              //Colors.transparent
                                            )
                                          : Future.delayed(
                                                  const Duration(seconds: 2))
                                              .then(
                                              (_) => Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                AppRoutes.homeScreen,
                                                //arguments: HomeScreenArgs(),
                                                (Route<dynamic> route) => false,
                                              ),
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
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'PNRegular',
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).primaryIconTheme.color),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: .0, left: 20, right: 20),
                              child: NextButtonWidget.purple(
                                label: "${I10n.of(context).share} ",
                                onTap: () {
                                  //TODO checkear en telef fisico que funcione sin pedir contactos
                                  Share.share(
                                      "${I10n.of(context).i_got} ${widget.result} ${I10n.of(context).of_} ${widget.questionsLenght} ${I10n.of(context).questions} ${I10n.of(context).in_} ${widget.quizTitle} ${I10n.of(context).in_} ${I10n.of(context).the_app} ${I10n.of(context).appTitle}");
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 20, right: 20),
                              child: NextButtonWidget.transparent(
                                label: I10n.of(context).backTo_Home,
                                fontColor: Theme.of(context).hintColor,
                                onTap: () async {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRoutes.homeScreen,
                                    arguments: HomeScreenArgs(),
                                    (Route<dynamic> route) => false,
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
