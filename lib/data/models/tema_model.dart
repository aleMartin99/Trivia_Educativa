//import 'package:educational_quiz_app/view/shared/models/answer_model.dart';

import 'package:educational_quiz_app/data/models/nivel_model.dart';

class Tema {
  late String descripcion;
  late List<Nivel> niveles;
  // int iV;

  Tema({
    required this.descripcion,
  });

  Tema.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['descripcion'] = this.descripcion;
    data['niveles'] = this.niveles;

    return data;
  }
}
