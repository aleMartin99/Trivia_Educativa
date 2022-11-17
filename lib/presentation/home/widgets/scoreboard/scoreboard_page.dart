import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:trivia_educativa/presentation/home/widgets/scoreboard/scoreboard_card/scoreboard_card.dart';
import 'package:trivia_educativa/presentation/home/widgets/scoreboard/scoreboard_state.dart';
import 'dart:math' show pi;
import '../../../../core/core.dart';
import '../../../../data/models/auth_model.dart';
import '../../../../main.dart';
import 'scoreboard_controller.dart';

class ScoreBoardPage extends StatefulWidget {
  const ScoreBoardPage({Key? key}) : super(key: key);

  @override
  State<ScoreBoardPage> createState() => _ScoreBoardPageState();
}

class _ScoreBoardPageState extends State<ScoreBoardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var auth = sl<Auth>();
  final scoreboardController = ScoreBoardController();
  void _loadData() async {
    await scoreboardController.getScoreGeneral(auth.token);
    //TODO pasar curso por el estudiante
    await scoreboardController.getScorebyAnno(auth.token, 1);
    // await homeController.getEstudiante(auth.user.ci, auth.token);

    // Estudiante estudiante = homeController.estudiante!;
    // await homeController.getAsignaturas(estudiante.annoCurso, auth.token);

    // await homeController.getNotasProv(auth.user.ci, auth.token);
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _loadData();
    scoreboardController.stateNotifier.addListener(() {
      setState(() {});
      if (scoreboardController.state == ScoreBoardState.error) {
        QuickAlert.show(
          context: context,

          type: QuickAlertType.error,
          title: 'Ha ocurrido un error',
          text: 'Ha ocurrido un error inesperado',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
          confirmBtnText: 'Ok',
          //confirmBtnTextStyle: const TextStyle(color: AppColors.white),
        );
        scoreboardController.state = ScoreBoardState.empty;
      }
      //TODO change message
      if (scoreboardController.state == ScoreBoardState.serverError) {
        QuickAlert.show(
          context: context,

          type: QuickAlertType.error,
          title: 'Se exploto el servr',
          text: 'Explotao, 500 papu',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
          confirmBtnText: 'Ok',
          //confirmBtnTextStyle: const TextStyle(color: AppColors.white),
        );
        scoreboardController.state = ScoreBoardState.empty;
      } else if (scoreboardController.state == ScoreBoardState.notConnected) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: 'No hay conexión a Internet',
          confirmBtnText: 'Ok',
          text:
              'Al parecer no tiene conexión a internet. Revise en los ajustes del teléfono',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );

        scoreboardController.state = ScoreBoardState.empty;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const angle = 180 * pi / 180;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: SizedBox(
              height: 270,
              child: Stack(
                children: [
                  Container(
                      height: 161,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: const BoxDecoration(
                        gradient: AppGradients.linear,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(top: 60),
                            title: Text(
                              'Tabla de Posiciones',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppTextStyles.titleBold,
                            ),

                            //overflow: TextOverflow.ellipsis,

                            leading: Transform.rotate(
                              angle: angle,
                              child: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                onPressed: () {
                                  AwesomeDrawerBar.of(context)?.toggle();
                                },
                              ),
                            ),
                            trailing: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppTheme.backgroundColors(
                                          Brightness.dark)
                                      : AppColors.lightPurple
                                  //AppColors.lightPurple,

                                  ),
                              // color: Colors.blue,
                              width: 75,
                              height: 75,
                              padding: const EdgeInsets.all(5),
                              child: FittedBox(
                                child: CustomIconSVG(
                                  iconName: AppImages.icon_trophy,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TabBar(
                    indicator: MaterialIndicator(
                        height: 4,
                        bottomLeftRadius: 6,
                        topLeftRadius: 8,
                        topRightRadius: 8,
                        horizontalPadding: 80,
                        strokeWidth: 2,
                        color: AppColors.purple,
                        tabPosition: TabPosition.bottom
                        //distanceFromCenter: 16,
                        //radius: 3,
                        // paintingStyle: PaintingStyle.fill,
                        ),
                    automaticIndicatorColorAdjustment: true,
                    controller: _tabController,
                    splashBorderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                    tabs: [
                      Text("Mi Año",
                          style: AppTextStyles.titleBold
                              .copyWith(color: AppColors.black)
                          //.copyWith(color: Colors.black),
                          ),
                      Text(
                        "General",
                        style: AppTextStyles.titleBold
                            .copyWith(color: AppColors.black),
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),

                SizedBox(
                  height: 24,
                ),

//TODO make validation for data to all pages like asignatura(home)
//TODO change app bar to sliver

                (scoreboardController.state == ScoreBoardState.loading)
                    ? const Center(
                        child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
                      ))
                    : (scoreboardController.scoreboardCurso == null ||
                            scoreboardController.scoreboardCurso!.isEmpty)
                        ?
                        //TODO I10n
                        Center(
                            child: Text(
                            'No hay tabla de posiciones por anno disponible',
                            style: AppTextStyles.titleBold.copyWith(
                              color: Theme.of(context).primaryIconTheme.color,
                            ),
                          ))
                        : SizedBox(
                            height: 500,
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  //*scoreboard anno
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    child: ListView(
                                      // padding: EdgeInsets.only(bottom: 15),
                                      clipBehavior: Clip.antiAlias,
                                      // useMagnifier: true,
                                      itemExtent: 120,
                                      physics: const BouncingScrollPhysics(),
                                      children: scoreboardController
                                          .scoreboardCurso!
                                          .map((scoreboardGeneral) {
                                        //   TODO check with nuevas notasProv
                                        // TODO check is done level with notasProv, llamar methodo en init state cargar notasProv
                                        //  if (doneLevel(nivel.id, widget.notas)) {
                                        return ScoreBoardCard(
                                          name: scoreboardGeneral.name,
                                          promedio: scoreboardGeneral.promedio,
                                        );
                                        // } else {
                                        //   return;
                                        //   NivelCardWidget(
                                        //       isDone: false,
                                        //       nombre: nivel.descripcion,
                                        //       preguntas: nivel.preguntas,
                                        //       onTap: () async {
                                        //         (nivel.preguntas.isEmpty)
                                        //             ? QuickAlert.show(
                                        //                 context: context,
                                        //                 type: QuickAlertType.warning,
                                        //                 title: 'No existen preguntas',
                                        //                 confirmBtnText: 'Ok',
                                        //                 text:
                                        //                     'No hay preguntas disponibles por el momento',
                                        //                 backgroundColor: Theme.of(context)
                                        //                     .scaffoldBackgroundColor,
                                        //                 textColor: Theme.of(context)
                                        //                     .primaryIconTheme
                                        //                     .color!,
                                        //                 titleColor: Theme.of(context)
                                        //                     .primaryIconTheme
                                        //                     .color!,
                                        //                 confirmBtnColor: AppColors.purple,
                                        //               )
                                        //             : Navigator.pushNamed(
                                        //                 context,
                                        //                 AppRoutes.challengeRoute,
                                        //                 arguments: ChallengePageArgs(
                                        //                     preguntas: nivel.preguntas,
                                        //                     idEstudiante: widget.idEstudiante,
                                        //                     nota5: nivel.nota5,
                                        //                     quizTitle: nivel.descripcion,
                                        //                     idAsignatura: widget.idAsignatura,
                                        //                     idTema: widget.idTema,
                                        //                     nivel: nivel),
                                        //               );

                                        //         // homeController.state = HomeState.empty;:
                                        //       });
                                        // }
                                      }).toList(),
                                    ),
                                  ),
                                  //*scoreboard general

                                  ListView(
                                    // padding: EdgeInsets.only(bottom: 15),
                                    clipBehavior: Clip.antiAlias,
                                    // useMagnifier: true,
                                    itemExtent: 120,
                                    physics: const BouncingScrollPhysics(),
                                    // children:
                                    // scoreboardController.scoreboardCurso.map((scoreboardGeneral) {

                                    //   if (doneLevel(nivel.id, widget.notas)) {
                                    //     return
                                    //     //  NivelCardWidget(
                                    //     //   isDone: true,
                                    //     //   nombre: nivel.descripcion,
                                    //     //   preguntas: nivel.preguntas,
                                    //     //   onTap: () {
                                    //     //     Navigator.pushNamed(
                                    //     //       context,
                                    //     //       AppRoutes.challengeRoute,
                                    //     //       arguments: ChallengePageArgs(
                                    //     //           preguntas: nivel.preguntas,
                                    //     //           idEstudiante: widget.idEstudiante,
                                    //     //           nota5: nivel.nota5,
                                    //     //           quizTitle: nivel.descripcion,
                                    //     //           idAsignatura: widget.idAsignatura,
                                    //     //           idTema: widget.idTema,
                                    //     //           nivel: nivel),
                                    //     //     );
                                    //     //   },
                                    //     // );
                                    //   }
                                    //    else {
                                    //     return ;
                                    //     // NivelCardWidget(
                                    //     //     isDone: false,
                                    //     //     nombre: nivel.descripcion,
                                    //     //     preguntas: nivel.preguntas,
                                    //     //     onTap: () async {
                                    //     //       (nivel.preguntas.isEmpty)
                                    //     //           ? QuickAlert.show(
                                    //     //               context: context,
                                    //     //               type: QuickAlertType.warning,
                                    //     //               title: 'No existen preguntas',
                                    //     //               confirmBtnText: 'Ok',
                                    //     //               text:
                                    //     //                   'No hay preguntas disponibles por el momento',
                                    //     //               backgroundColor: Theme.of(context)
                                    //     //                   .scaffoldBackgroundColor,
                                    //     //               textColor: Theme.of(context)
                                    //     //                   .primaryIconTheme
                                    //     //                   .color!,
                                    //     //               titleColor: Theme.of(context)
                                    //     //                   .primaryIconTheme
                                    //     //                   .color!,
                                    //     //               confirmBtnColor: AppColors.purple,
                                    //     //             )
                                    //     //           : Navigator.pushNamed(
                                    //     //               context,
                                    //     //               AppRoutes.challengeRoute,
                                    //     //               arguments: ChallengePageArgs(
                                    //     //                   preguntas: nivel.preguntas,
                                    //     //                   idEstudiante: widget.idEstudiante,
                                    //     //                   nota5: nivel.nota5,
                                    //     //                   quizTitle: nivel.descripcion,
                                    //     //                   idAsignatura: widget.idAsignatura,
                                    //     //                   idTema: widget.idTema,
                                    //     //                   nivel: nivel),
                                    //     //             );

                                    //     //       // homeController.state = HomeState.empty;:
                                    //     //     });
                                    //   }
                                    // }

                                    //  ).toList(),
                                  )
                                ]),
                          )
              ],
            ),
          ),
        ));
  }
}
