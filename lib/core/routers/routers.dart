import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_educativa/presentation/home/home_imports.dart';
import 'package:trivia_educativa/presentation/nivel/nivel_page.dart';
import 'package:trivia_educativa/presentation/tema/tema_page.dart';
import 'package:flutter/material.dart';

import 'package:trivia_educativa/presentation/challenge/challenge_page.dart';
import 'package:trivia_educativa/presentation/login/login_page.dart';
import 'package:trivia_educativa/presentation/result/result_page.dart';

import '../../data/models/models.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/onboarding/cubit/onboarding_cubit.dart';
import '../../presentation/onboarding/presenter/pages/on_boarding_page.dart';

const String homeRoute = "/home";
const String homeScreenRoute = "/homeScreen";
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
    final args = settings.arguments;

    switch (settings.name) {
      case challengeRoute:
        if (args is ChallengePageArgs) {
          return MaterialPageRoute(
            builder: (_) => ChallengePage(
              nota5: args.nota5,
              quizTitle: args.quizTitle,
              preguntas: args.preguntas,
              asignatura: args.asignatura,
              idTema: args.idTema,
              nivel: args.nivel,
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
              asignatura: args.asignatura,
              idEstudiante: args.idEstudiante,
              notas: args.notas,
            ),
          );
        } else {
          return _errorRoute();
        }

      case nivelRoute:
        if (args is NivelPageArgs) {
          return MaterialPageRoute(
            builder: (_) => NivelPage(
              tema: args.tema,
              niveles: args.niveles,
              asignatura: args.asignatura,
              idEstudiante: args.idEstudiante,
              notas: args.notas,
            ),
          );
        } else {
          return _errorRoute();
        }

      case resultRoute:
        if (args is ResultPageArgs) {
          return MaterialPageRoute(
            builder: (_) => ResultPage(
              notaValor: args.notaValor,
              isConnected: args.isConnected,
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

//*OnBoarding
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const Onboarding());

      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
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
        child: Text('Error'),
      ),
    );
  });
}

class HomePageArgs {}

class HomeScreenArgs {}

class ChallengePageArgs {
  final List<Pregunta> preguntas;
  final String quizTitle;
  final int nota5;
  final Asignatura asignatura;
  final String idTema;
  final Nivel nivel;
  final String idEstudiante;

  ChallengePageArgs(
      {required this.preguntas,
      required this.quizTitle,
      required this.nota5,
      required this.idTema,
      required this.asignatura,
      required this.nivel,
      required this.idEstudiante});
}

class TemaPageArgs {
  final Asignatura asignatura;
  final String idEstudiante;
  final List<NotaProv> notas;
  TemaPageArgs({
    required this.asignatura,
    required this.idEstudiante,
    required this.notas,
  });
}

class ResultPageArgs {
  final String quizTitle;
  final int questionsLenght;
  final int result;
  final int notaValor;
  final bool isConnected;

  ResultPageArgs(
      {required this.quizTitle,
      required this.questionsLenght,
      required this.result,
      required this.notaValor,
      required this.isConnected});
}

class NivelPageArgs {
  final List<Nivel> niveles;
  final Tema tema;
  final Asignatura asignatura;
  final String idEstudiante;
  final List<NotaProv> notas;

  NivelPageArgs(
      {required this.niveles,
      required this.tema,
      required this.asignatura,
      required this.idEstudiante,
      required this.notas});
}
