// import 'package:educational_quiz_app/data/models/asingatura_model.dart';
// import 'package:educational_quiz_app/data/models/profesor_model.dart';
// import 'package:educational_quiz_app/data/models/quiz_model.dart';
// import 'package:educational_quiz_app/data/models/tema_model.dart';
// import 'package:educational_quiz_app/domain/repositories/tema_repository.dart';
// import 'package:educational_quiz_app/presentation/home/home_state.dart';
// import 'package:educational_quiz_app/presentation/tema/tema_state.dart';
// //import 'package:dev_quiz/view/shared/models/user_model.dart';
// import 'package:flutter/material.dart';

// class TemaController {
//   final ValueNotifier<TemaState> stateNotifier =
//       ValueNotifier<TemaState>(TemaState.empty);
//   set state(TemaState state) => stateNotifier.value = state;
//   TemaState get state => stateNotifier.value;

//   // UserModel? user;
//   List<QuizModel>? quizzes;
//   List<Asignatura>? asignaturas;
//   List<Profesor>? profesores;
//   List<Tema>? temas;

//   final repository = TemaRepository();

//   // void getUser() async {
//   //   state = HomeState.loading;

//   //   user = await repository.getUser();

//   //   state = HomeState.success;
//   // }

// //   Future getQuizzes() async {
// //     state = HomeState.loading;

// //     quizzes = (await repository.getQuizzes()).cast<QuizModel>();
// //     //asignaturas = (await repository.fetchAsignaturas()).cast<Asignatura>();

// //     state = HomeState.success;
// //   }

// // //todo fix this controller shit
// //   Future getAsignaturas() async {
// //     state = HomeState.loading;
// //     // final Map<String,dynamic> list_asignaturas= jsonDecode()
// //     asignaturas = (await repository.getAsignaturas()).cast<Asignatura>();
// //     state = HomeState.success;
// //     return asignaturas;
// //   }

// //   Future getProfesores() async {
// //     state = HomeState.loading;
// //     profesores = (await repository.getProfesores()).cast<Profesor>();
// //     state = HomeState.success;
// //     return profesores;
// //   }

//   Future getTemas() async {
//     state = TemaState.loading;
//     temas = (await repository.getTemas()).cast<Tema>();
//     state = TemaState.success;
//     return temas;
//   }
// }
