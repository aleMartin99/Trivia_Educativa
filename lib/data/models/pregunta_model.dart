import 'package:trivia_educativa/data/models/answer_model.dart';

class Pregunta {
  late String id;
  late String descripcion;
  late String tiposDePregunta;
  late String imagen;

  //TODO add tipo pregunta
  //V o F, 4 x 1, imagen

//vof => resp correcta e incorrecta
// 4 x 1 => como ahora
//image => change imagen x descripcion y resto como ahora
  late List<AnswerModel> answers;

  Pregunta({
    required this.id,
    required this.descripcion,
    required this.tiposDePregunta,
    required this.imagen,
    required this.answers,
  }) : assert(
          answers.length == 4,
        );

  Pregunta.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    descripcion = json['descripcion'];
    answers = <AnswerModel>[];

    answers.add(AnswerModel(title: json['respuestaCorrecta'], isRight: true));
    answers.add(AnswerModel(
      title: json['respuestaIncorrecta'],
    ));
    answers.add(AnswerModel(
      title: json['respuestaIncorrecta1'],
    ));
    answers.add(AnswerModel(
      title: json['respuestaIncorrecta2'],
    ));
    imagen = json['imagen'];
    tiposDePregunta = json['tiposDePregunta'];
    answers.shuffle();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['descripcion'] = descripcion;
    data['respuestaCorrecta'] = answers[0].title;
    data['respuestaIncorrecta1'] = answers[1].title;
    data['respuestaIncorrecta2'] = answers[2].title;
    data['respuestaIncorrecta3'] = answers[3].title;
    return data;
  }
}
