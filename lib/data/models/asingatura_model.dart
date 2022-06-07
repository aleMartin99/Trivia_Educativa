// // import 'package:educational_quiz_app/view/shared/models/answer_model.dart';

// class AsignaturaModel {
//   AsignaturaModel({required this.data});
//   late final List<AsignData> data;
//   // final List<AnswerModel> answers;

//   // AsignaturaModel({
//   //   required this.descripcion,
//   //   // required this.answers,
//   // });
//   // : assert(
//   //         answers.length == 4,
//   //       ); //usando o assert para garantir a integridade do layout, ja que ele espera 4 respostas

//   AsignaturaModel.fromJson(Map<String, dynamic> json) {
//     data = List.from(json['data']).map((e) => AsignData.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['data'] = data.map((e) => e.toJson()).toList();
//     // 'answers': answers.map((x) => x.toMap()).toList(),

//     return _data;
//   }
// }
// class AsignData {
//   AsignData({required this.data});
//  late final data;

// }
//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'descripcion': descripcion,
//   //     // 'answers': answers.map((x) => x.toMap()).toList(),
//   //   };
//   // }

//   // factory AsignaturaModel.fromMap(Map<String, dynamic> map) {
//   //   return AsignaturaModel(
//   //     descripcion: map['descripcion'],
//   //     // answers: List<AnswerModel>.from(
//   //     //     map['answers'].map((x) => AnswerModel.fromMap(x))),
//   //   );
//   // }

//   // String toJson() => json.encode(toMap());

//   // factory AsignaturaModel.fromJson(String source) =>
//   //     AsignaturaModel.fromMap(json.decode(source));
// // }

class Asignatura {
  Asignatura({
    required this.data,
  });

  late final List<AsignaturaData> data;

  Asignatura.fromJson(Map<String, dynamic> json) {
    data =
        List.from(json['data']).map((e) => AsignaturaData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AsignaturaData {
  AsignaturaData({
    required this.id,
    required this.asignDescription,
  });
  late final int id;

  late final String asignDescription;

  AsignaturaData.fromJson(Map<String, dynamic> json) {
    id = json['task_id'];

    asignDescription = json['task_description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['task_id'] = id;

    _data['task_description'] = asignDescription;

    return _data;
  }
}
