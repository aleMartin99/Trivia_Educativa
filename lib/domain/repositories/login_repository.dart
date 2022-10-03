import 'dart:convert';
import 'package:trivia_educativa/core/error/failures.dart';

import 'package:trivia_educativa/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';

import '../../core/api_constants.dart';

class LoginRepository {
  final String _baseUrl = kApiEmulatorBaseUrl;

  Future<Either<Failure, List<User>>> getUsers() async {
    var uri = Uri.http(
      _baseUrl,
      "usuarios",
    );
    //TODO make a try catch
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List;
        final usuarios = jsonResponse.map((e) => User.fromJson(e)).toList();
        //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();

        return right(usuarios);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load Users');
      }
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
    //return getJson(uri).then((value) => value);
  }
}
