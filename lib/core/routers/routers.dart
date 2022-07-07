import 'package:educational_quiz_app/data/models/nivel_model.dart';
import 'package:educational_quiz_app/data/models/pregunta_model.dart';
import 'package:educational_quiz_app/data/models/tema_model.dart';
import 'package:educational_quiz_app/presentation/nivel/nivel_page.dart';
import 'package:educational_quiz_app/presentation/settings/settings_page.dart';
import 'package:educational_quiz_app/presentation/tema/tema_page.dart';
import 'package:flutter/material.dart';

import 'package:educational_quiz_app/presentation/challenge/challenge_page.dart';
import 'package:educational_quiz_app/presentation/home/home_page.dart';
import 'package:educational_quiz_app/presentation/login/login_page.dart';
import 'package:educational_quiz_app/presentation/result/result_page.dart';
import 'package:educational_quiz_app/data/models/user_model.dart';
import 'package:educational_quiz_app/presentation/splash/splash_page.dart';

const String splashRoute = "/";
const String homeRoute = "/home";
const String temaRoute = "/tema";
const String nivelRoute = "/nivel";
const String challengeRoute = "/challenge";
const String resultRoute = "/result";
const String loginRoute = "/login";
const String settingsRoute = "/settings";

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments; // pegando os argumentos caso haja

    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case challengeRoute:
        if (args is ChallengePageArgs) {
          return MaterialPageRoute(
            builder: (_) => ChallengePage(
              rango3: args.rango3,
              rango4: args.rango4,
              rango5: args.rango5,
              quizTitle: args.quizTitle,
              preguntas: args.preguntas,
              idAsignatura: args.idAsignatura,
              idCurso: args.idCurso,
              idTema: args.idTema,
              idNivel: args.idNivel,
            ),
          );
        } else {
          return _errorRoute();
        }
      case temaRoute:
        if (args is TemaPageArgs) {
          return MaterialPageRoute(
            builder: (_) => TemaPage(
              temas: args.temas, idAsignatura: args.idAsignatura,
              idCurso: args.idCurso,
              // questions: args.questions,
            ),
          );
        } else {
          return _errorRoute();
        }

      case nivelRoute:
        if (args is NivelPageArgs) {
          return MaterialPageRoute(
            builder: (_) => NivelPage(
              niveles: args.niveles,
              idAsignatura: args.idAsignatura,
              idCurso: args.idCurso,
              idTema: args.idTema,
            ),
          );
        } else {
          return _errorRoute();
        }

      case resultRoute:
        if (args is ResultPageArgs) {
          return MaterialPageRoute(
            builder: (_) => ResultPage(
              puntos: args.puntos,
              rango3: args.rango3,
              rango4: args.rango4,
              rango5: args.rango5,
              quizTitle: args.quizTitle,
              result: args.result,
              questionsLenght: args.questionsLenght,
              idAsignatura: args.idAsignatura,
              idCurso: args.idCurso,
              idTema: args.idTema,
              idNivel: args.idNivel,
            ),
          );
        } else {
          return _errorRoute();
        }
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case settingsRoute:
        if (args is SettingsPageArgs) {
          return MaterialPageRoute(
            builder: (_) => SettingsPage(
              user: args.user,
            ),
          );
        } else {
          return _errorRoute();
        }

      default:
        if (args is HomePageArgs) {
          return MaterialPageRoute(
            builder: (_) => HomePage(
              user: args.user,
            ),
          );
        } else {
          return _errorRoute();
        }
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}

class HomePageArgs {
  final User user;
  HomePageArgs({
    required this.user,
  });
}

class SettingsPageArgs {
  final User user;
  SettingsPageArgs({
    required this.user,
  });
}

class ChallengePageArgs {
  final List<Pregunta> preguntas;
  final String quizTitle;
  final int rango3;
  final int rango4;
  final int rango5;
  final String idAsignatura;
  final String idCurso;
  final String idTema;
  final String idNivel;

  ChallengePageArgs(
      {required this.preguntas,
      required this.quizTitle,
      required this.rango3,
      required this.rango4,
      required this.rango5,
      required this.idTema,
      required this.idAsignatura,
      required this.idCurso,
      required this.idNivel});
}

class TemaPageArgs {
  final List<Tema> temas;
  final String idAsignatura;
  final String idCurso;
  //TODO fix this after carlos fix the disaster with adding note
  TemaPageArgs(
      {required this.temas, required this.idAsignatura, required this.idCurso});
}

class ResultPageArgs {
  final String quizTitle;
  final int questionsLenght;
  final int result;
  final int rango3;
  final int rango4;
  final int rango5;
  final int puntos;
  final String idAsignatura;
  final String idCurso;
  final String idTema;
  final String idNivel;

  ResultPageArgs(
      {required this.quizTitle,
      required this.questionsLenght,
      required this.result,
      required this.rango3,
      required this.rango4,
      required this.rango5,
      required this.puntos,
      required this.idTema,
      required this.idAsignatura,
      required this.idCurso,
      required this.idNivel});
}

class NivelPageArgs {
  final List<Nivel> niveles;
  final String idTema;
  final String idAsignatura;
  final String idCurso;

  NivelPageArgs({
    required this.niveles,
    required this.idTema,
    required this.idAsignatura,
    required this.idCurso,
  });
}
