import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:trivia_educativa/core/error/exceptions.dart';

import '../api_constants.dart';

/// Parses general errors into program errors
mixin RequestErrorParser {
  // dynamic getResponse() async {
  //   String apiBaseUrl = kApiOldServer;
  //   var uri = Uri.http(
  //     apiBaseUrl,
  //     "notas",
  //   );
  //   final response = await http.get(uri);
  //   return response;
  // }

  Exception analyzeResponse(Response _result) {
    log('Error in api service. ${_result.reasonPhrase}}');
    // final _statusCode = _result.body?['code'] ?? _result.statusCode;
    final _statusCode = _result.statusCode;
    if (_statusCode >= 500) {
      return const ServerException(
        message: 'Error Interno en el Servidor ',
      );
    }
//Todo check status correct carlos
    if (_statusCode == 401) {
      return const AuthenticationException(message: 'Credenciales invalidas');
    } else {
      return const UnexpectedException(
        message: 'Ha ocurrido un error inesperado',
      );
    }
  }
}
