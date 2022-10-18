import 'package:trivia_educativa/data/models/asingatura_model.dart';
import 'package:trivia_educativa/data/models/curso_model.dart';
import 'package:trivia_educativa/data/models/estudiante_model.dart';
import 'package:trivia_educativa/data/models/nivel_model.dart';
import 'package:trivia_educativa/data/models/tema_model.dart';

//TODO fix after carlos fix the backend
//TODO modify
class NotaProv {
  late String id;
  List<Asignatura>? asignatura;
  List<Curso>? curso;
  List<Tema>? tema;
  List<Nivel>? nivel;
  List<Estudiante>? estudiante;
  late int nota;

  NotaProv({
    required this.id,
    this.asignatura,
    this.curso,
    this.tema,
    this.nivel,
    this.estudiante,
    required this.nota,
  });

  NotaProv.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['asignatura'] != null) {
      asignatura = <Asignatura>[];
      json['asignatura'].forEach((v) {
        asignatura!.add(Asignatura.fromJson(v));
      });
    }
    if (json['curso'] != null) {
      curso = <Curso>[];
      json['curso'].forEach((v) {
        curso!.add(Curso.fromJson(v));
      });
    }
    if (json['tema'] != null) {
      tema = <Tema>[];
      json['tema'].forEach((v) {
        tema!.add(Tema.fromJson(v));
      });
    }
    if (json['nivel'] != null) {
      nivel = <Nivel>[];
      json['nivel'].forEach((v) {
        nivel!.add(Nivel.fromJson(v));
      });
    }
    if (json['estudiante'] != null) {
      estudiante = <Estudiante>[];
      json['estudiante'].forEach((v) {
        estudiante!.add(Estudiante.fromJson(v));
      });
    }
    nota = json['nota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (asignatura != null) {
      data['asignatura'] = asignatura!.map((v) => v.toJson()).toList();
    }
    if (curso != null) {
      data['curso'] = curso!.map((v) => v.toJson()).toList();
    }
    if (tema != null) {
      data['tema'] = tema!.map((v) => v.toJson()).toList();
    }
    if (nivel != null) {
      data['nivel'] = nivel!.map((v) => v.toJson()).toList();
    }
    if (estudiante != null) {
      data['estudiante'] = estudiante!.map((v) => v.toJson()).toList();
    }
    data['nota'] = nota;

    return data;
  }
}
