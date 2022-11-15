import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/data/models/auth_model.dart';
import '../../core/core.dart';

import 'package:http/http.dart' as http;

import '../../core/network_info/network_info.dart';

class LoginRepository with RequestErrorParser {
  LoginRepository(
    this._networkInfo,
  );
  final NetworkInfo _networkInfo;
  String apiBaseUrl = kApiEmulatorBaseUrl;

  // Future pingTheServer() async {
  //   var uri = Uri.http(
  //     apiBaseUrl,
  //     kApiPath + 'asignatura',
  //   );

  //   if (await _networkInfo.isConnected) {
  //     try {
  //       final response = await http.get(
  //         uri,
  //       );
  //       log('verificando coneccion con el server');
  //       if (response.statusCode == 200) {
  //         log('status code from checking Server ${response.statusCode.toString()}');
  //         final jsonResponse = json.decode(response.body);
  //         log(' ${jsonResponse.toString()}');

  //         // final auth = Auth.fromJson(jsonResponse);
  //         return right(jsonResponse);
  //       } else if (response.statusCode == 401) {
  //         log('status code from checking Server ${response.statusCode.toString()}');
  //         //  return response;
  //       } else {
  //         throw Exception('Error checking server');

  //         //TODO I10n

  //       }
  //     } catch (e) {
  //       return left(const ServerFailure());
  //     }
  //   } else {
  //     return left(NoInternetConnectionFailure);
  //   }
  // }

  // Future bd() async {
  //   // This example uses the Google Books API to search for books about requests.
  //   // https://developers.google.com/books/docs/overview
  //   var url = 'https://google.com';
  //   try {
  //     final response = await Requests.get(url, timeoutSeconds: 1);
  //     // Await the http get response, then decode the json-formatted response.
  //     // var response = await Requests.get(url, timeoutSeconds: 10);
  //     if (response.statusCode == 200) {
  //       var jsonResponse = response.json();
  //       // var itemCount = jsonResponse["totalItems"];
  //       log('Number of books about requests: ${response.statusCode}');
  //     } else {
  //       log('Request failed with status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     return left(ServerFailure(message: e.toString()));
  //   }
  // }

  Future signIn(String username, String password) async {
    var uri = Uri.http(
      apiBaseUrl,
      kApiPath + 'auth/signin',
    );
    if (await _networkInfo.isConnected) {
      try {
        final response = await http.post(
          uri,
          body: {"username": username, "password": password},
        );
        log('pasar credenciales');
        //TODO validacion para timeout, si internet no server
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
        //TODO hacer estado timeout sin server per o con internet
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
