import 'dart:convert';
import 'package:trivia_educativa/core/error/failures.dart';

import 'package:trivia_educativa/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';

import '../../core/api_constants.dart';

class LoginRepository {
  //TODO check from recarguita como se inicializa el kApi const
  final String _baseUrl = kApiOldServer;
//TODO annadir token variable global

  //TODO fix el por que se esta llamando apenas abre la app sin hacer nada y da error
  Future<Either<Failure, List<User>>> getUsers() async {
    var uri = Uri.http(
      _baseUrl,
      "usuarios",
      //TODO add Authority
    );
    //TODO make a try catch
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        //TODO check carlos status cuando usuario es null (ahora da 500 y tiene que ser 401)
        final jsonResponse = json.decode(response.body) as List;
        final usuarios = jsonResponse.map((e) => User.fromJson(e)).toList();
        //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();

        return right(usuarios);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        //TODO arregkar excepciones
        throw Exception('Failed to load Users');
      }
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
    //return getJson(uri).then((value) => value);
  }
}
