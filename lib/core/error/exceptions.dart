//This file contains exceptions. Add Exceptions in here.
//Some basic exceptions example were provided.

class UnexpectedException implements Exception {
  final String? message;
  const UnexpectedException({this.message});
}

class ParsingException implements Exception {
  const ParsingException();
}

class ServerException implements Exception {
  final String? message;
  const ServerException({this.message});
}

class AuthenticationException implements Exception {
  final String? message;
  const AuthenticationException({this.message});
}

class CacheException implements Exception {
  final String? message;
  const CacheException({this.message});
}

class MaxRetryAttemptsReachedException implements Exception {
  final String? message;
  const MaxRetryAttemptsReachedException({this.message});
}

class ClientException implements Exception {
  final String? message;
  const ClientException({this.message});
}
