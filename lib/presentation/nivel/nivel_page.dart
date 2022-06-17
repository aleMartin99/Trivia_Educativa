import 'dart:developer';

import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/data/models/asingatura_model.dart';
import 'package:educational_quiz_app/data/models/nivel_model.dart';
import 'package:educational_quiz_app/data/models/user_model.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
import 'package:educational_quiz_app/domain/repositories/home_repository.dart';
import 'package:educational_quiz_app/presentation/home/home_controller.dart';
import 'package:educational_quiz_app/presentation/home/home_state.dart';
import 'package:educational_quiz_app/presentation/home/widgets/appbar/app_bar_widget.dart';
import 'package:educational_quiz_app/presentation/home/widgets/quiz_card/quiz_card_widget.dart';
// import 'package:educational_quiz_app/presentation/home/widgets/level_button/level_button_widget.dart';
import 'package:educational_quiz_app/presentation/nivel/widgets/nivel_card/nivel_card_widget.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:http/http.dart' as http;

class NivelPage extends StatefulWidget {
  const NivelPage({
    Key? key,
    required this.niveles,
  }) : super(key: key);
  final List<Nivel> niveles;
  @override
  _NivelPageState createState() => _NivelPageState();
}

class _NivelPageState extends State<NivelPage> {
  //final controller = HomeController();
  final controller = HomeController();
  void _loadData() async {
    await controller.getQuizzes();
    log('entro al nivel page init state');
    // await controller.getAsignaturas();
    //  await controller.getProfesores();
    // await controller.getCursos();
  }

  @override
  initState() {
    _loadData();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  // initState() {
  //  // controller.getQuizzes();
  //    //controller.stateNotifier.addListener(() {
  //   setState(() {});

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // log(controller.toString());
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Scaffold(
        backgroundColor:
            settingsController.currentAppTheme.scaffoldBackgroundColor,

// LinearGradient(colors: [
//     Color(0xFF57B6E0),
//     Color.fromARGB(153, 81, 6, 255),
//   ], stops: [
//     0.0,
//     0.695
//   ], transform: GradientRotation(2.13959913 * pi));
//todo fucking gradient
        appBar: AppBar(
          toolbarHeight: kToolbarHeight,
          title: const Text('Niveles'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              // ListView(
              //   primary: false,
              //   shrinkWrap: true,

              //   children: controller.quizzes!
              //       .map(
              //         (quiz) => QuizCardWidget(
              //           title: quiz.title,
              //           subtitle: quiz.subtitle,
              //           completed: quiz.questionsAnswered,
              //           totalQuestions: quiz.questions.length,
              //           onTap: () {
              //             Navigator.pushNamed(
              //               context,
              //               AppRoutes.challengeRoute,
              //               arguments: ChallengePageArgs(
              //                 questions: quiz.questions,
              //                 quizTitle: quiz.title,
              //               ),
              //             );
              //           },
              //         ),
              //       )
              //       .toList(),
              //   //  return Column(
              //   //       children: [
              //   //         Text(controller.asignaturas![index].descripcion),
              //   //         // Text(controller
              //   //         //     .asignaturas![index].profesor[index].nombre)
              //   //       ],
              //   //     );
              // ),
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                //*info:  botones de dificultad
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     LevelButtonWidget(
                //       label: "Fácil",
                //     ),
                //     LevelButtonWidget(
                //       label: "Médio",
                //     ),
                //     LevelButtonWidget(
                //       label: "Difícil",
                //     ),
                //     LevelButtonWidget(
                //       label: "Perito",
                //     ),
                //   ],
                // ),
              ),
              // GridView.count(
              //   shrinkWrap: true,
              //   crossAxisCount: 2,
              //   crossAxisSpacing: 16,
              //   mainAxisSpacing: 16,
              //   children: controller.quizzes!
              //       .map(
              //         (quiz) => QuizCardWidget(
              //           title: quiz.title,
              //           subtitle: quiz.subtitle,
              //           completed: quiz.questionsAnswered,
              //           totalQuestions: quiz.questions.length,
              //           onTap: () {
              //             Navigator.pushNamed(
              //               context,
              //               AppRoutes.challengeRoute,
              //               arguments: ChallengePageArgs(
              //                 questions: quiz.questions,
              //                 quizTitle: quiz.title,
              //               ),
              //             );
              //           },
              //         ),
              //       )
              //       .toList(),
              // ),

              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: widget.niveles
                    // widget.asignatura.cursos.last.temas.last.niveles
                    .map(
                      (nivel) => NivelCardWidget(
                        //TODO revisar x que le paso tods los paramtos al cardwidget
                        nombre: nivel.descripcion,
                        rango3: nivel.rango3,
                        rango4: nivel.rango4,
                        rango5: nivel.rango5,
                        preguntas: nivel.preguntas,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.challengeRoute,
                            arguments: ChallengePageArgs(
                              preguntas: nivel.preguntas,
                              quizTitle: nivel.descripcion,
                            ),
                          );
                        },
                      ),
                      //         // children: widget.asignatura.cursos.last.temas!.last.niveles
                      //         //     .map((nivel) => NivelCardWidget(
                      //         //             nombre: nivel.descripcion,
                      //         //             //todo coger cant de niveles dinamico
                      //         //            // cantNiveles: tema.niveles.length,
                      //         //             onTap: () {
                      //         //               Navigator.pushNamed(
                      //         //                 context,
                      //         //                 AppRoutes.challengeRoute,
                      //         //                 // arguments: const TemaPage(),
                      //         //               );
                      //         //             }, rango3: 0, rango4: 0, rango5: 0,preguntas: []
                      //         //             ,subtitle: 'Preguntas',)
                      //         //    QuizCardWidget(
                      //         //     title: 'Nombre Quiz',
                      //         //     // asignatura.id,

                      //         //     //  asignatura.descripcion,
                      //         //     completed: 0,
                      //         //     totalQuestions: 2,
                      //         //     onTap: () {
                      //         //       // Navigator.pushNamed(
                      //         //       //   context,
                      //         //       //   AppRoutes.challengeRoute,
                      //         //       //   arguments: ChallengePageArgs(
                      //         //       //     questions: quiz.questions,
                      //         //       //     quizTitle: quiz.title,
                      //         //       //   ),
                      //         //       // );
                      //         //     },
                      //         //   ),
                    )
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
