import 'package:trivia_educativa/data/models/pregunta_model.dart';

class Nivel {
  late String id;
  late String descripcion;
  late List<Pregunta> preguntas;

  late int nota5;
  late int duracion;

  Nivel({
    required this.id,
    required this.descripcion,
    required this.preguntas,
    required this.nota5,
    required this.duracion,
  });

  Nivel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    descripcion = json['descripcion'];
    if (json['preguntas'] != null) {
      preguntas = <Pregunta>[];
      json['preguntas'].forEach((v) {
        preguntas.add(Pregunta.fromJson(v));
      });
    }
    nota5 = json['nota5'];
    duracion = json['tiempoDuracion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = id;
    data['descripcion'] = descripcion;
    data['preguntas'] = preguntas.map((v) => v.toJson()).toList();
    data['nota5'] = nota5;
    return data;
  }
}
