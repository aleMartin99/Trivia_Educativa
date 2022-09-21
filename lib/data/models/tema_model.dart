//import 'package:educational_quiz_app/view/shared/models/answer_model.dart';

import 'package:trivia_educativa/data/models/nivel_model.dart';

class Tema {
  late String id;
  late String descripcion;
  late List<Nivel> niveles;
  // int iV;

  Tema({required this.descripcion, required this.id, required this.niveles});

  Tema.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    descripcion = json['descripcion'];
    // niveles = json['niveles'];
    if (json['niveles'] != null) {
      niveles = <Nivel>[];
      json['niveles'].forEach((v) {
        niveles.add(Nivel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = id;
    data['descripcion'] = descripcion;
    data['niveles'] = niveles;

    return data;
  }
}
