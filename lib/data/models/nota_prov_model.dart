import 'package:trivia_educativa/data/models/asignatura_model.dart';
import 'package:trivia_educativa/data/models/estudiante_model.dart';
import 'package:trivia_educativa/data/models/nivel_model.dart';
import 'package:trivia_educativa/data/models/tema_model.dart';

//TODO modify after microservices backend
class NotaProv {
  late String id;
  //TODO change to id
  late List<Asignatura> asignatura;
  //id nota
  late List<Tema> tema;
  late List<Nivel> nivel;
  //TODO pass only de estudiante ID
  late List<Estudiante> estudiante;
// late List<Estudiante>? estudiante;
  late int nota;

  NotaProv({
    required this.id,
    required this.asignatura,
    required this.tema,
    required this.nivel,
    required this.estudiante,
    required this.nota,
  });

  NotaProv.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['asignatura'] != null) {
      estudiante = <Estudiante>[];
      json['estudiante'].forEach((v) {
        estudiante.add(Estudiante.fromJson(v));
      });
    }

    if (json['asignatura'] != null) {
      asignatura = <Asignatura>[];
      json['asignatura'].forEach((v) {
        asignatura.add(Asignatura.fromJson(v));
      });
    }

    if (json['tema'] != null) {
      tema = <Tema>[];
      json['tema'].forEach((v) {
        tema.add(Tema.fromJson(v));
      });
    }
    if (json['nivel'] != null) {
      nivel = <Nivel>[];
      json['nivel'].forEach((v) {
        nivel.add(Nivel.fromJson(v));
      });
    }
    // if (json['estudiante'] != null) {
    //   estudiante = <Estudiante>[];
    //   json['estudiante'].forEach((v) {
    //     estudiante!.add(Estudiante.fromJson(v));
    //   });
    // }
    nota = json['nota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (asignatura != null) {
      data['asignatura'] = asignatura.map((v) => v.toJson()).toList();
    }

    if (tema != null) {
      data['tema'] = tema.map((v) => v.toJson()).toList();
    }
    if (nivel != null) {
      data['nivel'] = nivel.map((v) => v.toJson()).toList();
    }
    // if (estudiante != null) {
    //   data['estudiante'] = estudiante!.map((v) => v.toJson()).toList();
    // }
    data['nota'] = nota;

    return data;
  }
}
