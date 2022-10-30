import 'dart:developer';

import 'package:http/http.dart';
import 'package:trivia_educativa/core/error/exceptions.dart';

/// Parses general errors into program errors
mixin RequestErrorParser {
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
