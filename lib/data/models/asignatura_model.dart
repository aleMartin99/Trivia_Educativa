//import 'package:educational_quiz_app/view/shared/models/answer_model.dart';
import 'package:trivia_educativa/core/app_icons.dart';
import 'package:trivia_educativa/core/app_images.dart';
import 'package:trivia_educativa/core/app_sounds.dart';
import 'package:trivia_educativa/data/models/tema_model.dart';

class Asignatura {
  late String id;
  late String descripcion;
  late int anno;
  late List<Tema> temas;

  // late String icon;
  late String image;
  late String icon;
  late String soundtrack;
  //TODO annadir imagen e icono

  Asignatura(
      {required this.id,
      required this.descripcion,
      required this.anno,
      required this.temas,
      required this.image,
      required this.icon,
      required this.soundtrack});

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
    if (json['configuracion'] != null &&
        (json['configuracion'] as List).isNotEmpty) {
      // List <String>  config = <String>[];
      image = json['configuracion'][0];
      icon = json['configuracion'][1];
      soundtrack = json['configuracion'][2];
    } else {
      image = AppImages.randomTema();
      icon = AppIcons.icon_1;
      soundtrack = AppSpunds.soundtrack_1;
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
