//import 'package:educational_quiz_app/view/shared/models/answer_model.dart';
import 'package:trivia_educativa/data/models/pregunta_model.dart';

class Nivel {
  late String id;
  late String descripcion;
  late List<Pregunta> preguntas;
  late int rango3;
  late int rango4;
  late int rango5;

  Nivel({
    required this.id,
    required this.descripcion,
    required this.preguntas,
    required this.rango3,
    required this.rango4,
    required this.rango5,
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
    rango3 = json['nota3'];
    rango4 = json['nota4'];
    rango5 = json['nota5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = id;

    data['descripcion'] = descripcion;

    data['preguntas'] = preguntas.map((v) => v.toJson()).toList();

    data['nota3'] = rango3;
    data['nota4'] = rango4;
    data['nota5'] = rango5;

    return data;
  }
}
