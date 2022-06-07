//import 'package:easy_api/easy_api.dart';
import 'package:educational_quiz_app/view/shared/models/asingatura_model.dart';
import 'package:educational_quiz_app/view/shared/network/asignatura_network.dart';
import 'package:flutter/material.dart';

// class AsignaturaRepository extends EasyModelWrapper {
//   final AsignaturaNetwork asignaturaNetwork;

//   AsignaturaRepository({required this.asignaturaNetwork});

//   Future fetchAsignaturas() async {
//     try {
//       return nestedModelDecoder(
//           jsonFormat: Asignatura.fromJson,
//           parentTypeClass: Asignatura,
//           response: await asignaturaNetwork.fetchAsignaturas(),
//           childTypeClass: AsignaturaData);
//     } on EasyException catch (exception) {
//       debugPrint(exception.message);
//     }
//   }
// }
