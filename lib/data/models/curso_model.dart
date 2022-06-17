import 'package:educational_quiz_app/data/models/estudiante_model.dart';
import 'package:educational_quiz_app/data/models/tema_model.dart';

//todo coger el nombre al que pertenece, no el anno
class Curso {
  late String id;
  late DateTime? fecha;
  List<Estudiante>? estudiantes;
  late List<Tema> temas;

  Curso({
    required this.id,
    required this.fecha,
    required this.estudiantes,
    required this.temas,
  });

  Curso.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    // fecha = json['fecha'] != null ? Fecha.fromJson(json['fecha']) : null;
    fecha = DateTime.tryParse(json['fecha']);
    if (json['estudiantes'] != null) {
      estudiantes = <Estudiante>[];
      json['estudiantes'].forEach((v) {
        estudiantes!.add(Estudiante.fromJson(v));
      });
    }
    if (json['temas'] != null) {
      temas = <Tema>[];
      json['temas'].forEach((v) {
        temas.add(Tema.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['_id'] = id;

    data['fecha'] = fecha;

    if (this.estudiantes != null) {
      data['estudiantes'] = this.estudiantes!.map((v) => v.toJson()).toList();
    }
    if (this.temas != null) {
      data['temas'] = this.temas.map((v) => v.toJson()).toList();
    }

    return data;
  }

  @override
  String toString() {
    return fecha!.year.toString();
  }
}

// class Fecha {
//   Date? date;

//   Fecha({this.date});

//   Fecha.fromJson(Map<String, dynamic> json) {
//     date = json['$date'] != null ?  Date.fromJson(json['$date']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.date != null) {
//       data['$date'] = this.date!.toJson();
//     }
//     return data;
//   }
// }

// class Date {
//   String? numberLong;

//   Date({this.numberLong});

//   Date.fromJson(Map<String, dynamic> json) {
//     numberLong = json['$numberLong'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['$numberLong'] = this.numberLong;
//     return data;
//   }
// }
