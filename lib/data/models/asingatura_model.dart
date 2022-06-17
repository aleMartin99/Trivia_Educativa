//import 'package:educational_quiz_app/view/shared/models/answer_model.dart';
import 'package:educational_quiz_app/data/models/profesor_model.dart';

import 'curso_model.dart';

class Asignatura {
  late String id;
  late String descripcion;
  late List<Profesor> profesores;
  late List<Curso> cursos;
  // int iV;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['_id'] = this.id;

    data['descripcion'] = this.descripcion;
    if (this.profesores != null) {
      data['profesor'] = this.profesores.map((v) => v.toJson()).toList();
    }
    if (this.cursos != null) {
      data['cursos'] = this.cursos.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
