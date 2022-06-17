import 'package:educational_quiz_app/data/models/asingatura_model.dart';
import 'package:educational_quiz_app/data/models/profesor_model.dart';
import 'package:educational_quiz_app/data/models/quiz_model.dart';
import 'package:educational_quiz_app/domain/repositories/home_repository.dart';
import 'package:educational_quiz_app/presentation/home/home_state.dart';
import 'package:educational_quiz_app/presentation/nivel/nivel_state.dart';
//import 'package:dev_quiz/view/shared/models/user_model.dart';
import 'package:flutter/material.dart';

class NivelController {
  final ValueNotifier<NivelState> stateNotifier =
      ValueNotifier<NivelState>(NivelState.empty);
  set state(NivelState state) => stateNotifier.value = state;
  NivelState get state => stateNotifier.value;

  // UserModel? user;
  //List<QuizModel>? quizzes;
  List<Asignatura>? asignaturas;
  List<Profesor>? profesores;

  final repository = HomeRepository();

  // void getUser() async {
  //   state = HomeState.loading;

  //   user = await repository.getUser();

  //   state = HomeState.success;
  // }

//   Future getQuizzes() async {
//     state = HomeState.loading;

//     quizzes = (await repository.getQuizzes()).cast<QuizModel>();
//     //asignaturas = (await repository.fetchAsignaturas()).cast<Asignatura>();

//     state = HomeState.success;
//   }

// //todo fix this controller shit
//   Future getAsignaturas() async {
//     state = HomeState.loading;
//     // final Map<String,dynamic> list_asignaturas= jsonDecode()
//     asignaturas = (await repository.getAsignaturas()).cast<Asignatura>();
//     state = HomeState.success;
//     return asignaturas;
//   }

//   Future getProfesores() async {
//     state = HomeState.loading;
//     profesores = (await repository.getProfesores()).cast<Profesor>();
//     state = HomeState.success;
//     return profesores;
//   }
}
