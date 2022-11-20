import 'package:trivia_educativa/data/models/models.dart';

class ScoreBoard {
  late double promedio;
//  late String name;
  late Estudiante estudiante;
  //TODO add scoreboard id
  //late String id;

  // {
  //   "promedio": 2,
  //   "estudiantes": [
  //     {
  //       "_id": "637716860935311ca19bbea1",
  //       "name": "Carlos Daniel de la Noval",
  //       "CI": "88888888888",
  //       "annoCurso": 4,
  //       "createdAt": "2022-11-18T05:22:14.351Z",
  //       "updatedAt": "2022-11-18T05:22:14.351Z",
  //       "__v": 0
  //     }
  //   ]
  // }
  ScoreBoard({
    required this.promedio,
    required this.estudiante,
    //TODO add scoreboard id required this.id
    // this.imagen
  });

  ScoreBoard.reciprocal(double d) {
    1 / d;
  }

  ScoreBoard.fromJson(Map<String, dynamic> json) {
    if (json['promedio'] is int) {
      int x = json['promedio'];

      ScoreBoard.reciprocal(x.toDouble());
      promedio = x.toDouble();
    } else {
      promedio = json['promedio'];
    }

//  if (json['temas'] != null) {
//       temas = <Tema>[];
//       json['temas'].forEach((v) {
//         temas.add(Tema.fromJson(v));
//       });
//     }

    if (json['estudiantes'] != null) {
      List<Estudiante> estuds = <Estudiante>[];
      json['estudiantes'].forEach((v) {
        estuds.add(Estudiante.fromJson(v));
      });
      estudiante = estuds.last;
    }

    //name = (json['name']);
    //TODO add scoreboard id   id = (json['name']);
  }
}
