import 'package:trivia_educativa/data/models/models.dart';

class ScoreBoardItem {
  late double promedio;
  late Estudiante estudiante;

  ScoreBoardItem({
    required this.promedio,
    required this.estudiante,
  });

  ScoreBoardItem.reciprocal(double d) {
    1 / d;
  }

  ScoreBoardItem.fromJson(Map<String, dynamic> json) {
    if (json['promedio'] is int) {
      int x = json['promedio'];

      ScoreBoardItem.reciprocal(x.toDouble());
      promedio = x.toDouble();
    } else {
      promedio = json['promedio'];
    }

    if (json['estudiantes'] != null) {
      List<Estudiante> estuds = <Estudiante>[];
      json['estudiantes'].forEach((v) {
        estuds.add(Estudiante.fromJson(v));
      });
      estudiante = estuds.last;
    }
  }
}
