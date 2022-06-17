// import 'dart:convert';

// import 'package:educational_quiz_app/data/models/pregunta_model.dart';
// import 'package:educational_quiz_app/data/models/question_model.dart';

// // enum Level { facil, medio, dificil, perito }

// // // essa extensao vai ser adicionada nas possibilidades da String
// // extension LevelStringExt on String {
// //   Level get levelParseFromString => {
// //         "facil": Level.facil,
// //         "medio": Level.medio,
// //         "dificil": Level.dificil,
// //         "perito": Level.perito,
// //       }[this]!; // o this representa a string que se esta passando
// // }

// // extension LevelExt on Level {
// //   String get levelParseFromLevel => {
// //         Level.facil: "facil",
// //         Level.medio: "medio",
// //         Level.dificil: "dificil",
// //         Level.perito: "perito",
// //       }[this]!; // o this representa a string que se esta passando
// // }

// class QuizModel {
//   final String title;
//   //final String subtitle;
//   final List<Pregunta> questions;
//   final int questionsAnswered;
//   final String image;
//   // final Level level;

//   QuizModel({
//     required this.title,
//     //required this.subtitle,
//     required this.questions,
//     this.questionsAnswered = 0,
//     required this.image,
//     //  required this.level,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       // 'subtitle': subtitle,

//       'questions': questions.map((v) => v.toMap()).toList(),

//       //  'questions': questions.map((x) => x.toMap()).toList(),
//       'questionsAnswered': questionsAnswered,
//       'image': image,
//       //  'level': level.levelParseFromLevel,
//     };
//   }

//   factory QuizModel.fromMap(Map<String, dynamic> map) {
//     return QuizModel(
//       title: map['title'],
//       //  subtitle: map['subtitle'],
//       questions: List<Pregunta>.from(map['questions'].map((x) => Pregunta)),
//       questionsAnswered: map['questionsAnswered'],
//       image: map['image'],
//       //  level: map['level'].toString().levelParseFromString,
//     );
//   }

//   // String toJson() => json.encode(toMap());

//   factory QuizModel.fromJson(String source) =>
//       QuizModel.fromMap(json.decode(source));

// // if (json['preguntas'] != null) {
// //       preguntas = <Pregunta>[];
// //       json['preguntas'].forEach((v) {
// //         preguntas.add(Pregunta.fromJson(v));
// //       });
// //     }

// }
