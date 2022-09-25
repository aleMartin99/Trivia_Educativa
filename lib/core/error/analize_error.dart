// import 'dart:developer';


// import 'package:http/http.dart';
// import 'package:trivia_educativa/core/error/exceptions.dart';

// /// Parses general errors into program errors
// mixin RequestErrorParser {
//   Exception analyzeResponse(Response _result) {
//     log('Error in api service. ${_result.error}}');
//     final _statusCode = _result.body?['code'] ?? _result.statusCode;
//     if (_statusCode >= 500) {
//       return ServerException(
//         message: _result.body?['message'],
//       );
//     }

//     if (_statusCode == 403) {
//       return const AuthenticationException();
//     } else {
//       return UnexpectedException(
//         message: _result.body?['message'],
//       );
//     }
//   }
// }
