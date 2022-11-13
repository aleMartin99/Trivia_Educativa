import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/data/models/models.dart';
import '../../core/core.dart';

import 'package:http/http.dart' as http;

import '../../core/network_info/network_info.dart';

class ChallengeRepository with RequestErrorParser {
  ChallengeRepository(this._networkInfo);
  String apiBaseUrl = kApiEmulatorBaseUrl;
  final NetworkInfo _networkInfo;
// //TODO keep implementing right left get notas prov method

//TODO implement from estudinate byCI con left and right
  Future<Either<Failure, List<NotaProv>>> getNotasProv() async {
    var uri = Uri.http(
      //TODO change to  "api/v2/" "other thing",
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

//TODO implement from estudinate byCI con left and right
//TODO check
  Future addDatos(String idNotaProv, String idAsignatura, String idTema,
      String idNivel, String idEstudiante) async {
    var uri = Uri.http(
      // apiBaseUrl,
      '10.0.2.2:3000',
      "api/v2/"
          "notas/$idNotaProv/asignatura/$idAsignatura/tema/$idTema/nivel/$idNivel/estudiante/$idEstudiante",
    );

    if (await _networkInfo.isConnected) {
      try {
        final response = await http.post(uri);
        log('status code from asignarNota');
        log(response.statusCode.toString());
        log('asignar nota ');
        // if (response.statusCode == 200) {
        //         final jsonResponse = json.decode(response.body);
        //         log(' ${jsonResponse.toString()}');
        //         final estudiante = Estudiante.fromJson(jsonResponse);
        //         return right(estudiante);
        //       }
        if (response.statusCode == 401) {
          return left(InvalidCredentialsFailure);
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          //TODO I10n
          throw Exception('Failed to asign to a Nota');
        }
      } catch (e) {
        return left(UnexpectedFailure(message: e.toString()));
      }
    } else {
      return left(NoInternetConnectionFailure);
    }
  }

//TODO implement from estudinate byCI o user con left and right
  Future crearNota(int nota) async {
    var uri = Uri.http(
      //apiBaseUrl,
      '10.0.2.2:3000',
      "api/v2/"
          "notas",
    );

    if (await _networkInfo.isConnected) {
      try {
        final response = await http.post(uri, body: {"nota": "$nota"});
        log(' ${response.toString()}');
        if (response.statusCode == 201) {
          final jsonResponse = json.decode(response.body);
          log(' ${jsonResponse.toString()}');
          final notaProv = NotaProv.fromJson(jsonResponse);
          return right(notaProv);
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to create a Nota');
        }
      } catch (e) {
        return left(UnexpectedFailure(message: e.toString()));
      }
    } else {
      return left(NoInternetConnectionFailure);
    }
  }
}
