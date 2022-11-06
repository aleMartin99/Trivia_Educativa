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

// const String splashRoute = "/";
const String homeRoute = "/home";
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
              rango3: args.rango3,
              rango4: args.rango4,
              rango5: args.rango5,
              quizTitle: args.quizTitle,
              preguntas: args.preguntas,
              idAsignatura: args.idAsignatura,
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
              puntos: args.puntos,
              rango3: args.rango3,
              rango4: args.rango4,
              rango5: args.rango5,
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

//*OnBoarding
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const Onboarding());

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
      required this.idNivel});
}

class TemaPageArgs {
  final List<Tema> temas;
  final String idAsignatura;

  //TODO add id estudiante when adding note
  TemaPageArgs({
    required this.temas,
    required this.idAsignatura,
  });
}

class ResultPageArgs {
  //TODO remove puntos and rangos, add nota5
  final String quizTitle;
  final int questionsLenght;
  final int result;
  final int rango3;
  final int rango4;
  final int rango5;
  final int puntos;

//TODO remove puntos and rangos, add nota5
  ResultPageArgs({
    required this.quizTitle,
    required this.questionsLenght,
    required this.result,
    required this.rango3,
    required this.rango4,
    required this.rango5,
    required this.puntos,
  });
}

class NivelPageArgs {
  final List<Nivel> niveles;
  final String idTema;
  final String idAsignatura;

  NivelPageArgs({
    required this.niveles,
    required this.idTema,
    required this.idAsignatura,
  });
}
