import 'package:trivia_educativa/data/models/asingatura_model.dart';
import 'package:trivia_educativa/data/models/nota_prov_model.dart';
import 'package:trivia_educativa/data/models/user_model.dart';
import 'package:trivia_educativa/domain/repositories/home_repository.dart';
import 'package:trivia_educativa/presentation/home/home_state.dart';
//import 'package:dev_quiz/view/shared/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

//TODO separate controllers

class HomeController {
  final ValueNotifier<HomeState> stateNotifier =
      ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  List<Asignatura>? asignaturas;
  List<NotaProv>? notasProv;

  final repository = HomeRepository();

  Future getAsignaturas() async {
    state = HomeState.loading;
    final response = (await repository.getAsignaturas());
    if (response.isRight()) {
      asignaturas =
          ((response as Right).value as List<Asignatura>).cast<Asignatura>();
      state = HomeState.success;
      return asignaturas;
    } else {
      state = HomeState.error;
    }
  }

  Future getNotasProv() async {
    state = HomeState.loading;

    notasProv = (await repository.getNotasProv()).cast<NotaProv>();

    state = HomeState.success;
    return notasProv;
  }

//todo move to challenge controller
  Future asignarNota(String idAsignatura, String idCurso, String idTema,
      String idNivel, String idNotaProv) async {
    state = HomeState.loading;

    repository.asignarNota(idAsignatura, idCurso, idTema, idNivel, idNotaProv);

    state = HomeState.success;
    // return nota;
  }

  void crearNota(int nota) async {
    state = HomeState.loading;

    repository.crearNota(nota);

    state = HomeState.success;
    // return nota;
  }

  // Future getQuizzes() async {
  //   state = HomeState.loading;

  //   quizzes = (await repository.getQuizzes()).cast<QuizModel>();
  //   asignaturas = (await repository.fetchAsignaturas()).cast<Asignatura>();
  //   log('halo los quizzes');
  //   state = HomeState.success;
  // }

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
