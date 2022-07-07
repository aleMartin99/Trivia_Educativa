import 'package:educational_quiz_app/data/models/asingatura_model.dart';
import 'package:educational_quiz_app/data/models/nota_prov_model.dart';
import 'package:educational_quiz_app/data/models/user_model.dart';
import 'package:educational_quiz_app/domain/repositories/home_repository.dart';
import 'package:educational_quiz_app/presentation/home/home_state.dart';
//import 'package:dev_quiz/view/shared/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeController {
  final ValueNotifier<HomeState> stateNotifier =
      ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  List<User>? users;
  List<Asignatura>? asignaturas;
  List<NotaProv>? notasProv;

  //List<Profesor>? profesores;
  //List<Tema>? temas;
  //List<Curso>? cursos;
  // List<Nivel>? niveles;

  final repository = HomeRepository();

  Future getUser() async {
    state = HomeState.loading;

    users = (await repository.getUsers()).cast<User>();

    state = HomeState.success;
    return users;
  }

  Future getNotasProv() async {
    state = HomeState.loading;

    notasProv = (await repository.getNotasProv()).cast<NotaProv>();

    state = HomeState.success;
    return notasProv;
  }

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
