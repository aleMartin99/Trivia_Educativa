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
  late String image;
  late String icon;
  late String soundtrack;

  Asignatura(
      {required this.id,
      required this.descripcion,
      required this.anno,
      required this.temas,
      required this.image,
      required this.icon,
      required this.soundtrack});

  Asignatura.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
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
      //TODO change this to new model
      image = json['configuracion'][0];
      icon = json['configuracion'][1];
      soundtrack = json['configuracion'][2];
    }
    //* Add data for image, icon, soundtrack in case that they are empty
    else {
      image = AppImages.randomImageTema();
      icon = AppIcons.randomIcon();
      soundtrack = AppSounds.randomSoundTrack();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = id;
    data['descripcion'] = descripcion;
    data['anno'] = anno;
    data['temas'] = temas.map((v) => v.toJson()).toList();

    return data;
  }
}
