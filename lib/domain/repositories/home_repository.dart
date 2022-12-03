import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/data/models/models.dart';
import '../../core/core.dart';

import 'package:http/http.dart' as http;

import '../../core/network_info/network_info.dart';

class HomeRepository with RequestErrorParser {
  HomeRepository(
    this._networkInfo,
  );
  String apiBaseUrl = kApiAlePC;
  final NetworkInfo _networkInfo;

  Future findEstudianteByCI(String cI, String token) async {
    var uri = Uri.http(
      apiBaseUrl,
      kApiPath + "estudiante/byCI/" "$cI",
    );

    if (await _networkInfo.isConnected) {
      try {
        final response = await http.get(uri, headers: {
          'Authorization': 'Bearer $token',
        }).timeout(
          const Duration(seconds: 30),
        );
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          log(' ${jsonResponse.toString()}');
          final estudiante = Estudiante.fromJson(jsonResponse);
          return right(estudiante);
        } else if (response.statusCode == 401) {
          return left(InvalidCredentialsFailure);
        } else if (response.statusCode == 500) {
          return left(ServerFailure);
        } else {
          throw Exception('Failed to find Estudiante by CI');
        }
      } on ClientException {
        return left(ServerFailure);
      } on TimeoutException {
        return left(ServerFailure);
      } on HttpException {
        return left(ServerFailure);
      } on SocketException {
        return left(ServerFailure);
      } on ServerException {
        return left(ServerFailure);
      } catch (e) {
        return left(UnexpectedFailure(message: e.toString()));
      }
    } else {
      return left(NoInternetConnectionFailure);
    }
  }

  Future findByAnno(int annoCurso, String token) async {
    var uri = Uri.http(
      apiBaseUrl,
      kApiPath + "asignatura/obtener/" "$annoCurso",
    );
    if (await _networkInfo.isConnected) {
      try {
        final response = await http.get(uri, headers: {
          'Authorization': 'Bearer $token',
        }).timeout(
          const Duration(seconds: 30),
        );
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body) as List;
          log(' ${jsonResponse.toString()}');
          final asignaturas =
              jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
          return right(asignaturas);
        } else if (response.statusCode == 401) {
          return left(InvalidCredentialsFailure);
        } else if (response.statusCode == 500) {
          return left(ServerFailure);
        } else {
          throw Exception('Failed to load Asingaturas');
        }
      } on ClientException {
        return left(ServerFailure);
      } on TimeoutException {
        return left(ServerFailure);
      } on HttpException {
        return left(ServerFailure);
      } on SocketException {
        return left(ServerFailure);
      } on ServerException {
        return left(ServerFailure);
      } catch (e) {
        return left(UnexpectedFailure(message: e.toString()));
      }
    } else {
      return left(NoInternetConnectionFailure);
    }
  }

  Future getNotasProv(String cI, String token) async {
    var uri = Uri.http(
      apiBaseUrl,
      kApiPath + "notas/allNotas/" "$cI",
    );
    if (await _networkInfo.isConnected) {
      try {
        final response = await http.get(uri, headers: {
          'Authorization': 'Bearer $token',
        }).timeout(
          const Duration(seconds: 30),
        );
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body) as List;
          final notasProv =
              jsonResponse.map((e) => NotaProv.fromJson(e)).toList();
          return right(notasProv);
        } else if (response.statusCode == 500) {
          return left(ServerFailure);
        } else {
          throw Exception('Failed to load Notas');
        }
      } on ClientException {
        return left(ServerFailure);
      } on TimeoutException {
        return left(ServerFailure);
      } on HttpException {
        return left(ServerFailure);
      } on SocketException {
        return left(ServerFailure);
      } on ServerException {
        return left(ServerFailure);
      } catch (e) {
        return left(UnexpectedFailure(message: e.toString()));
      }
    } else {
      return left(NoInternetConnectionFailure);
    }
  }
}
