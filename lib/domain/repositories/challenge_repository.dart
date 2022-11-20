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

  Future addDatos(String idNotaProv, String idAsignatura, String idTema,
      String idNivel, String idEstudiante, String token) async {
    var uri = Uri.http(
      apiBaseUrl,
      kApiPath +
          "notas/$idNotaProv/asignatura/$idAsignatura/tema/$idTema/nivel/$idNivel/estudiante/$idEstudiante",
    );

    if (await _networkInfo.isConnected) {
      try {
        final response = await http.post(uri, headers: {
          'Authorization': 'Bearer $token',
        });
        log('status code from asignarNota');
        log(response.statusCode.toString());

        if (response.statusCode == 201) {
          log('asignar nota ok');
        }
        if (response.statusCode == 500) {
          log('error server');
          return left(ServerFailure);
        }

        if (response.statusCode == 401) {
          return left(InvalidCredentialsFailure);
        } else {
          throw Exception('Failed to asign to a Nota');
        }
      } catch (e) {
        return left(UnexpectedFailure(message: e.toString()));
      }
    } else {
      return left(NoInternetConnectionFailure);
    }
  }

  Future crearNota(int nota, String token) async {
    var uri = Uri.http(
      apiBaseUrl,
      kApiPath + "notas",
    );

    if (await _networkInfo.isConnected) {
      try {
        final response = await http.post(uri, body: {
          "nota": "$nota"
        }, headers: {
          'Authorization': 'Bearer $token',
        });
        log(' ${response.toString()}');
        if (response.statusCode == 201) {
          final jsonResponse = json.decode(response.body);
          log(' ${jsonResponse.toString()}');
          final notaProv = NotaProv.fromJson(jsonResponse);
          return right(notaProv);
        }
        if (response.statusCode == 500) {
          log('error server');
          return left(ServerFailure);
        } else {
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
