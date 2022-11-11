import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/data/models/auth_model.dart';
import 'package:trivia_educativa/data/models/models.dart';
import '../../core/core.dart';

import 'package:http/http.dart' as http;

import '../../core/network_info/network_info.dart';

class LoginRepository with RequestErrorParser {
  LoginRepository(
    this._networkInfo,
  );
  final NetworkInfo _networkInfo;
  String apiBaseUrl = kApiEmulatorBaseUrl;

  Future signIn(String username, String password) async {
    var uri = Uri.http(
      '10.0.2.2:3000',
      "api/v2/auth/" "signin",
    );
    if (await _networkInfo.isConnected) {
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
        }
        //TODO hacer estado timeout
        else if (response.statusCode == 401) {
          return left(InvalidCredentialsFailure);
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          //TODO I10n
          throw Exception('Failed to load the user');
        }
      } catch (e) {
        return left(UnexpectedFailure(message: e.toString()));
      }
    } else {
      return left(NoInternetConnectionFailure);
    }
  }
}
