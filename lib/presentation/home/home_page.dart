import 'dart:developer';

import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
import 'package:educational_quiz_app/data/models/asingatura_model.dart';
import 'package:educational_quiz_app/data/models/user_model.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
import 'package:educational_quiz_app/domain/repositories/home_repository.dart';
import 'package:educational_quiz_app/presentation/home/home_controller.dart';
import 'package:educational_quiz_app/presentation/home/home_state.dart';
import 'package:educational_quiz_app/presentation/home/widgets/appbar/app_bar_widget.dart';
import 'package:educational_quiz_app/presentation/home/widgets/asignatura_card/asignatura_card_widget.dart';
// import 'package:educational_quiz_app/presentation/home/widgets/level_button/level_button_widget.dart';
import 'package:educational_quiz_app/presentation/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  // final cont

  void _loadData() async {
    // await controller.getQuizzes();
    await controller.getAsignaturas();
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

  @override
  Widget build(BuildContext context) {
    log(controller.toString());
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    if (controller.state == HomeState.success) {
      return Scaffold(
          backgroundColor:
              settingsController.currentAppTheme.scaffoldBackgroundColor,
          appBar: AppBarWidget(
            // perceba que aqui usamos o ! para garantir ao dart que o usuario nao sera nulo
            user: widget.user,
            context: context,
          ),
          body: (controller.state == HomeState.loading)
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
                ))
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
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
                      // //!prueba con asignatura
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: controller.asignaturas!
                            .map((asignatura) => AsignaturaCardWidget(
                                      nombre: asignatura.descripcion,
                                      //Todo hacer coger cant temas dinamico
                                      cantTemas: 1,
                                      //Todo hacer coger curso dinamico

                                      //todo curso poner el nombre del que pertences
                                      cursos: asignatura.cursos,

                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.temaRoute,
                                            arguments: TemaPageArgs(
                                                temas: asignatura
                                                    .cursos.last.temas));
                                      },
                                    )
                                //    QuizCardWidget(
                                //     title: 'Nombre Quiz',
                                //     // asignatura.id,

                                //     //  asignatura.descripcion,
                                //     completed: 0,
                                //     totalQuestions: 2,

                                //   ),
                                )
                            .toList(),
                      ),
                    ],
                  ),
                ));
    }
    return const Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
    ));
  }
}
