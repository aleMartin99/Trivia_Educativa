//import 'package:educational_quiz_app/view/shared/models/answer_model.dart';
import 'package:trivia_educativa/data/models/profesor_model.dart';

import 'curso_model.dart';

class Asignatura {
  late String id;
  late String descripcion;
  late List<Profesor> profesores;
  late List<Curso> cursos;

  Asignatura({
    required this.id,
    required this.descripcion,
    required this.profesores,
    required this.cursos,
  });

  Asignatura.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    descripcion = json['descripcion'];
    if (json['profesor'] != null) {
      profesores = <Profesor>[];
      json['profesor'].forEach((v) {
        profesores.add(Profesor.fromJson(v));
      });
    }
    if (json['cursos'] != null) {
      cursos = <Curso>[];
      json['cursos'].forEach((v) {
        cursos.add(Curso.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = id;
    data['descripcion'] = descripcion;
    data['profesor'] = profesores.map((v) => v.toJson()).toList();
    data['cursos'] = cursos.map((v) => v.toJson()).toList();

    return data;
  }
}
