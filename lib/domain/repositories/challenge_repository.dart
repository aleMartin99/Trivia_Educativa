import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/data/models/models.dart';
import '../../core/core.dart';

import 'package:http/http.dart' as http;

class ChallengeRepository with RequestErrorParser {
  String apiBaseUrl = kApiOldServer;

//  Future<Either<Failure, List<Asignatura>>> getAsignaturas() async {
// //
//     var uri = Uri.http(
//       apiBaseUrl,
//       "asignaturas",
//     );
//     try {
//       final response = await http.get(uri);
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body) as List;
//         final asignaturas =
//             jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
//         //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
//         return right(asignaturas);
//       } else {
//         // If the server did not return a 200 OK response,
//         // then throw an exception.
//         //TODO I10n
//         throw Exception('Failed to load Asingaturas');
//       }
//     } catch (e) {
//       return left(UnexpectedFailure(message: e.toString()));
//     }

//     //return getJson(uri).then((value) => value);
//   }

//TODO keep implementing right left get asignaturas method
  Future<Either<Failure, List<NotaProv>>> getNotasProv() async {
    var uri = Uri.http(
      apiBaseUrl,
      "notas",
    );
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List;
        final notasProv =
            jsonResponse.map((e) => NotaProv.fromJson(e)).toList();
        return right(notasProv);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load Notas');
      }
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }

    //return getJson(uri).then((value) => value);
  }

  Future asignarNota(String idAsignatura, String idTema, String idNivel,
      String idNotaProv) async {
    var uri = Uri.http(
      apiBaseUrl,
      "notas" "/$idNotaProv",
    );

    try {
      final response = await http.put(uri, body: {
        //TODO add id estudiante
        "asignatura": idAsignatura,
        "tema": idTema,
        "nivel": idNivel,
      });
      log('asignar nota ');
    } catch (ex) {
      throw Exception('Failed to asign a Nota');
    }
  }

  void crearNota(int nota) async {
    var uri = Uri.http(
      apiBaseUrl,
      "notas",
    );

    try {
      final response = await http.post(uri, body: {"nota": "$nota"});
      log(response.body);
    } catch (ex) {
      throw Exception('Failed to create a Nota');
    }
  }
}
