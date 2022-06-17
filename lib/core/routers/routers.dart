import 'package:educational_quiz_app/data/models/asingatura_model.dart';
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
import 'package:educational_quiz_app/data/models/question_model.dart';
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
              quizTitle: args.quizTitle,
              preguntas: args.preguntas,
            ),
          );
        } else {
          return _errorRoute();
        }
      case temaRoute:
        if (args is TemaPageArgs) {
          return MaterialPageRoute(
            builder: (_) => TemaPage(
              temas: args.temas,
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
            ),
          );
        } else {
          return _errorRoute();
        }

      case resultRoute:
        if (args is ResultPageArgs) {
          return MaterialPageRoute(
            builder: (_) => ResultPage(
              quizTitle: args.quizTitle,
              result: args.result,
              questionsLenght: args.questionsLenght,
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
  final UserModel user;
  HomePageArgs({
    required this.user,
  });
}

class SettingsPageArgs {
  final UserModel user;
  SettingsPageArgs({
    required this.user,
  });
}

class ChallengePageArgs {
  final List<Pregunta> preguntas;
  final String quizTitle;

  ChallengePageArgs({
    required this.preguntas,
    required this.quizTitle,
  });
}

class TemaPageArgs {
  List<Tema> temas;

  TemaPageArgs({required this.temas});
}

// class TemaPageArgs {
//   final String temaNombre;
//   final int temaCantNiveles;

//   TemaPageArgs({
//     required this.temaNombre,
//     required this.temaCantNiveles,
//   });
// }

class ResultPageArgs {
  final String quizTitle;
  final int questionsLenght;
  final int result;

  ResultPageArgs({
    required this.quizTitle,
    required this.questionsLenght,
    required this.result,
  });
}

class NivelPageArgs {
  final List<Nivel> niveles;

  NivelPageArgs({
    required this.niveles,
  });
}
