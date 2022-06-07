import 'dart:developer';

import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/routers/routers.dart';
import 'package:educational_quiz_app/view/home/home_controller.dart';
import 'package:educational_quiz_app/view/home/home_state.dart';
import 'package:educational_quiz_app/view/home/widgets/appbar/app_bar_widget.dart';
// import 'package:educational_quiz_app/view/home/widgets/level_button/level_button_widget.dart';
import 'package:educational_quiz_app/view/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:educational_quiz_app/view/settings/settings_controller.dart';
import 'package:educational_quiz_app/view/shared/models/asingatura_model.dart';
import 'package:educational_quiz_app/view/shared/models/user_model.dart';
import 'package:educational_quiz_app/view/shared/network/asignatura_network.dart';
import 'package:educational_quiz_app/view/shared/repositories/asignatura_repository.dart';
import 'package:educational_quiz_app/view/shared/network/http_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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

  //final String asignaturas = await netw.fetchAsignaturas();

  @override
  void initState() {
    controller.getQuizzes();
    // _loadJson();
    // adicionando um recurso que vai ficar observando atualizacoes da variavel statenotifier
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  _loadJson() async {
    String data = await HttpHandler().fetchAsignaturas();
    log(data);
  }

  @override
  Widget build(BuildContext context) {
// print('Response status: ${response.statusCode}');
//print('Response body: ${response.body}');

    // final AsignaturaRepository asignaturaRepository = AsignaturaRepository(
    //     asignaturaNetwork: AsignaturaNetwork(baseApiUrl: baseUrl));

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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            children: [
              FutureBuilder(
                  future: _loadJson(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      log('ok');
                      List<AsignaturaData> asignaturas =
                          snapshot.data as List<AsignaturaData>;

                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(asignaturas[index].asignDescription),
                          );
                        },
                        itemCount: asignaturas.length,
                        shrinkWrap: true,
                      );
                    }
                    return const Text('Error al cargar o no hay datos');
                  }),
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
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: controller.quizzes!
                      .map(
                        (quiz) => QuizCardWidget(
                          title: quiz.title,
                          completed: quiz.questionsAnswered,
                          totalQuestions: quiz.questions.length,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.challengeRoute,
                              arguments: ChallengePageArgs(
                                questions: quiz.questions,
                                quizTitle: quiz.title,
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
        )),
      );
    }
  }
}
