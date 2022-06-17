import 'dart:developer';

import 'package:educational_quiz_app/data/models/asingatura_model.dart';
import 'package:educational_quiz_app/data/models/curso_model.dart';
import 'package:educational_quiz_app/data/models/profesor_model.dart';
import 'package:educational_quiz_app/data/models/quiz_model.dart';
import 'package:educational_quiz_app/data/models/tema_model.dart';
import 'package:educational_quiz_app/domain/repositories/home_repository.dart';
import 'package:educational_quiz_app/presentation/home/home_state.dart';
//import 'package:dev_quiz/view/shared/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeController {
  final ValueNotifier<HomeState> stateNotifier =
      ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  // UserModel? user;
  // List<QuizModel>? quizzes;
  List<Asignatura>? asignaturas;
  //List<Profesor>? profesores;
  //List<Tema>? temas;
  //List<Curso>? cursos;
  // List<Nivel>? niveles;

  final repository = HomeRepository();

  // void getUser() async {
  //   state = HomeState.loading;

  //   user = await repository.getUser();

  //   state = HomeState.success;
  // }

  Future getQuizzes() async {
    state = HomeState.loading;

    //quizzes = (await repository.getQuizzes()).cast<QuizModel>();
    //asignaturas = (await repository.fetchAsignaturas()).cast<Asignatura>();
    log('halo los quizzes');
    state = HomeState.success;
  }

//todo fix this controller shit
  Future getAsignaturas() async {
    state = HomeState.loading;
    // final Map<String,dynamic> list_asignaturas= jsonDecode()
    asignaturas = (await repository.getAsignaturas()).cast<Asignatura>();
    state = HomeState.success;
    return asignaturas;
  }

  // Future getProfesores() async {
  //   state = HomeState.loading;
  //   profesores = (await repository.getProfesores()).cast<Profesor>();
  //   state = HomeState.success;
  //   return profesores;
  // }

  // Future getTemas() async {
  //   state = HomeState.loading;
  //   temas = (await repository.getTemas()).cast<Tema>();
  //   state = HomeState.success;
  //   return temas;
  // }

  // Future getCursos() async {
  //   state = HomeState.loading;
  //   cursos = (await repository.getCursos()).cast<Curso>();
  //   state = HomeState.success;
  //   return cursos;
  // }
}
