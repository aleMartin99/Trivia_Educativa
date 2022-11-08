import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/data/models/auth_model.dart';

import 'package:trivia_educativa/data/models/models.dart';
import '../../core/core.dart';

import 'package:http/http.dart' as http;

class LoginRepository with RequestErrorParser {
  String apiBaseUrl = kApiProductionBaseUrl;

//  {'username':'cecarlos',
//       'password':'123'
//       }

  //TODO fix el por que se esta llamando apenas abre la app sin hacer nada y da error
  // Future<Either<Failure, List<User>>> getUsers() async {
  //   var uri = Uri.http(
  //     apiBaseUrl,
  //     "usuarios",
  //     //TODO add Authority(token)
  //   );
  //   //TODO make a try catch con status
  //   try {
  //     final response = await http.get(uri);
  //     if (response.statusCode == 200) {
  //       //TODO implement home repository failure system
  //       //TODO check carlos status cuando usuario es null (ahora da 500 y tiene que ser 401)
  //       final jsonResponse = json.decode(response.body) as List;
  //       final usuarios = jsonResponse.map((e) => UserfromJson(e)).toList();
  //       //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();

  //       return right(usuarios);
  //     } else {
  //       // If the server did not return a 200 OK response,
  //       // then throw an exception.
  //       //TODO arreglar excepciones
  //       throw Exception('Failed to load Users');
  //     }
  //   } catch (e) {
  //     return left(UnexpectedFailure(message: e.toString()));
  //   }
  //   //return getJson(uri).then((value) => value);
  // }

  Future<Either<Failure, List<Asignatura>>> getAsignaturas() async {
//
    var uri = Uri.http(
      apiBaseUrl,
      "asignaturas",
    );
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List;
        final asignaturas =
            jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
        //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
        return right(asignaturas);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        //TODO I10n
        throw Exception('Failed to load Asingaturas');
      }
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future signIn(String username, String password) async {
    var uri = Uri.http(
      '10.0.2.2:3000',
      "api/v2/auth/" "signin",
    );

    try {
      final response = await http.post(
        uri,
        body: {"username": username, "password": password},
      );
      log('pasar credenciales');
      if (response.statusCode == 201) {
        //  final jsonResponse = json.decode(response.body) as List;
        //       final asignaturas =
        //           jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
        log(' ${response.statusCode.toString()}');
        final jsonResponse = json.decode(response.body);
        log(' ${jsonResponse.toString()}');
        final auth = Auth.fromJson(jsonResponse);
        // final user = jsonResponse.map((e) => User.fromJson(e));
        log('guardando el usuario ${auth.user.toString()}');
        return right(auth);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        //TODO I10n
        throw Exception('Failed to load the user');
      }
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }
}
