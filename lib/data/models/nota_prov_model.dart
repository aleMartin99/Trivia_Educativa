import 'models.dart';

//TODO remove pregunta and from jason pregunta
class NotaProv {
  late String id;
  late int nota;
  late List<Asignatura> asignatura;
  late List<Tema> tema;
  late List<Nivel> nivel;

  late List<Estudiante> estudiante;
// late List<Estudiante>? estudiante;

  NotaProv({
    required this.id,
    required this.nota,
    required this.asignatura,
    required this.tema,
    required this.nivel,
    required this.estudiante,
  });

  NotaProv.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nota = json['nota'];

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

    if (json['estudiante'] != null) {
      estudiante = <Estudiante>[];
      json['estudiante'].forEach((v) {
        estudiante.add(Estudiante.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    data['asignatura'] = asignatura.map((v) => v.toJson()).toList();

    data['tema'] = tema.map((v) => v.toJson()).toList();

    data['nivel'] = nivel.map((v) => v.toJson()).toList();
    data['nota'] = nota;

    return data;
  }
}
