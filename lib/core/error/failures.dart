import 'package:equatable/equatable.dart';

const String _kUnexpectedError = 'Sucedió algo inesperado';

abstract class Failure with EquatableMixin {
  const Failure({this.properties});

  final List? properties;

  @override
  String toString() => _kUnexpectedError;
  @override
  List<Object?> get props => [properties];
}

class ServerFailure extends Failure {
  const ServerFailure({this.message = 'Server Failure'});
  final String? message;

  @override
  String toString() => message ?? super.toString();
}

class ParsingFailure extends Failure {
  const ParsingFailure({this.message = 'Parsing Failure'});
  final String? message;

  @override
  String toString() => message ?? super.toString();
}

class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure({
    this.message =
        'Parece que no tienes conexión a internet. Por favor, revisa en los ajustes del teléfono',
  });
  final String? message;

  @override
  String toString() => message ?? super.toString();
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({this.message = 'Authentication Failure'});
  final String? message;

  @override
  String toString() => message ?? super.toString();
}

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure({this.message = 'Invalid Credentials Failure'});
  final String? message;

  @override
  String toString() => message ?? super.toString();
}

class EmailAlreadyTakenFailure extends Failure {
  EmailAlreadyTakenFailure({this.message = 'Email already taken Failure'});
  final String? message;

  @override
  String toString() => message ?? super.toString();
}

class EmailNotRegisteredFailure extends Failure {
  EmailNotRegisteredFailure({this.message = 'Email not registered Failure'});
  final String? message;

  @override
  String toString() => message ?? super.toString();
}

class CacheFailure extends Failure {
  const CacheFailure({this.message});
  final String? message;

  @override
  String toString() => message ?? super.toString();
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({this.message});
  final String? message;

  @override
  String toString() => message ?? super.toString();
}

class InvalidAppVersionFailure extends Failure {
  const InvalidAppVersionFailure({this.message});
  final String? message;

  @override
  String toString() => message ?? super.toString();
}
