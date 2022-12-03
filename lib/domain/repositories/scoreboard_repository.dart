import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/data/models/scoreboard_item_model.dart';
import '../../core/core.dart';

import 'package:http/http.dart' as http;

import '../../core/network_info/network_info.dart';

class ScoreBoardRepository with RequestErrorParser {
  ScoreBoardRepository(
    this._networkInfo,
  );
  String apiBaseUrl = kApiAlePC;
  final NetworkInfo _networkInfo;

  Future promedioGlobal(String token) async {
    var uri = Uri.http(
      apiBaseUrl,
      kApiPath + "notas/promedio/global",
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
          final scoreboardGeneral =
              jsonResponse.map((e) => ScoreBoardItem.fromJson(e)).toList();
          //   final promedioEstudiantes = ScoreBoard.fromJson(jsonResponse);
          return right(scoreboardGeneral);
        } else if (response.statusCode == 401) {
          return left(InvalidCredentialsFailure);
        } else if (response.statusCode == 500) {
          return left(ServerFailure);
        } else if (response is TimeoutException) {
          return left(ServerFailure);
        } else {
          throw Exception('Failed to load alumnos from promedio by General');
        }
      } on ClientException {
        //return left(ServerFailure);
      } on TimeoutException {
        // return left(ServerFailure);
      } on HttpException {
        //return left(ServerFailure);
      } on SocketException {
        //return left(ServerFailure);
      } on ServerException {
        //return left(ServerFailure);
      } catch (e) {
        return left(UnexpectedFailure(message: e.toString()));
      }
    } else {
      return left(NoInternetConnectionFailure);
    }
  }

  Future promedioAnnoCurso(String token, int curso) async {
    var uri = Uri.http(
      apiBaseUrl,
      kApiPath + "notas/promedio/" "$curso",
    );

    if (await _networkInfo.isConnected) {
      try {
        final response = await http.get(uri, headers: {
          'Authorization': 'Bearer $token',
        }).timeout(const Duration(seconds: 30));

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body) as List;
          log(' ${jsonResponse.toString()}');
          final scoreboardCurso =
              jsonResponse.map((e) => ScoreBoardItem.fromJson(e)).toList();
          return right(scoreboardCurso);
        } else {
          throw Exception('Failed to load alumnos from promedio by Curso');
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
