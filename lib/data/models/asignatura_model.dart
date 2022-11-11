//import 'package:educational_quiz_app/view/shared/models/answer_model.dart';
import 'package:trivia_educativa/data/models/profesor_model.dart';
import 'package:trivia_educativa/data/models/tema_model.dart';

class Asignatura {
  late String id;
  late String descripcion;
  late int anno;
  late List<Tema> temas;
  //late String image;
  //late String icon;
  //TODO annadir imagen e icono

  Asignatura({
    required this.id,
    required this.descripcion,
    required this.anno,
    required this.temas,
    // required this.image,
    // required this.icon,
  });

//TOdo Annadir fromjson para imagen e icono,

//TODO si esta vacio o null en imagen e icon pongo valor por defecto
  Asignatura.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    // icon = json['icon'];
    // image = json['image'];
    descripcion = json['descripcion'];
    anno = json['anno'];
    if (json['temas'] != null) {
      temas = <Tema>[];
      json['temas'].forEach((v) {
        temas.add(Tema.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = id;
    // data['icon'] = icon;
    // data['image'] = image;
    data['descripcion'] = descripcion;
    data['anno'] = anno;
    //  data['profesor'] = profesores.map((v) => v.toJson()).toList();
    data['temas'] = temas.map((v) => v.toJson()).toList();

    return data;
  }
}
