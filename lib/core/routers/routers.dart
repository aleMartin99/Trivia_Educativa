import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_educativa/data/models/nivel_model.dart';
import 'package:trivia_educativa/data/models/pregunta_model.dart';
import 'package:trivia_educativa/data/models/tema_model.dart';
import 'package:trivia_educativa/presentation/nivel/nivel_page.dart';
import 'package:trivia_educativa/presentation/settings/settings_page.dart';
import 'package:trivia_educativa/presentation/tema/tema_page.dart';
import 'package:flutter/material.dart';

import 'package:trivia_educativa/presentation/challenge/challenge_page.dart';
import 'package:trivia_educativa/presentation/home/home_page.dart';
import 'package:trivia_educativa/presentation/login/login_page.dart';
import 'package:trivia_educativa/presentation/result/result_page.dart';
import 'package:trivia_educativa/data/models/user_model.dart';

import '../../presentation/onboarding/cubit/onboarding_cubit.dart';
import '../../presentation/onboarding/presenter/pages/on_boarding_page.dart';

//TODO check routes and APP routes
// const String splashRoute = "/";
const String homeRoute = "/home";
const String homeScreen = "/homeScreen";
const String onboardingRoute = "/onboarding";
const String temaRoute = "/tema";
const String nivelRoute = "/nivel";
const String challengeRoute = "/challenge";
const String resultRoute = "/result";
const String loginRoute = "/login";
const String settingsRoute = "/settings";

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments; // pegando os argumentos caso haja

    switch (settings.name) {
      // case splashRoute:
      //   return MaterialPageRoute(builder: (_) => const SplashPage());
      case challengeRoute:
        if (args is ChallengePageArgs) {
          return MaterialPageRoute(
            builder: (_) => ChallengePage(
              nota5: args.nota5,
              quizTitle: args.quizTitle,
              preguntas: args.preguntas,
              idAsignatura: args.idAsignatura,
              idTema: args.idTema,
              idNivel: args.idNivel,
              idEstudiante: args.idEstudiante,
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
              idEstudiante: args.idEstudiante,

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
              idTema: args.idTema,
              idEstudiante: args.idEstudiante,
            ),
          );
        } else {
          return _errorRoute();
        }

      case resultRoute:
        if (args is ResultPageArgs) {
          return MaterialPageRoute(
            //TODO remove puntos and rangos, add nota5
            builder: (_) => ResultPage(
              nota5: args.nota5,
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
      // case settingsRoute:
      //   if (args is SettingsPageArgs) {
      //     return MaterialPageRoute(
      //       builder: (_) => const SettingsPage(),
      //     );
      //   } else {
      //     return _errorRoute();
      //   }

//TODO check this onboarding stuff with already seen
//*OnBoarding
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const Onboarding());

      case homeScreen:
        if (args is HomeScreenArgs) {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(
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

//TODO check this onboarding stuff with already seen
  @override
  Widget build(BuildContext context) {
    final _onboardingAlreadySeen = context.read<OnboardingCubit>().alreadySeen;
    if (_onboardingAlreadySeen == true) {
      return const LoginPage();
    }

    return const Onboarding();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        //TODO I10n
        child: Text('Ha ocurrido un error inesperado'),
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

class HomeScreenArgs {
  final User user;
  HomeScreenArgs({
    required this.user,
  });
}

// class SettingsPageArgs {
//   SettingsPageArgs();
// }

class ChallengePageArgs {
  final List<Pregunta> preguntas;
  final String quizTitle;
  final int nota5;
  final String idAsignatura;
  final String idTema;
  final String idNivel;
  final String idEstudiante;

  ChallengePageArgs(
      {required this.preguntas,
      required this.quizTitle,
      required this.nota5,
      required this.idTema,
      required this.idAsignatura,
      required this.idNivel,
      required this.idEstudiante});
}

class TemaPageArgs {
  final List<Tema> temas;
  final String idAsignatura;
  final String idEstudiante;

  TemaPageArgs({
    required this.temas,
    required this.idAsignatura,
    required this.idEstudiante,
  });
}

class ResultPageArgs {
  final String quizTitle;
  final int questionsLenght;
  final int result;
  final int nota5;

  ResultPageArgs({
    required this.quizTitle,
    required this.questionsLenght,
    required this.result,
    required this.nota5,
  });
}

class NivelPageArgs {
  final List<Nivel> niveles;
  final String idTema;
  final String idAsignatura;
  final String idEstudiante;

  NivelPageArgs(
      {required this.niveles,
      required this.idTema,
      required this.idAsignatura,
      required this.idEstudiante});
}
