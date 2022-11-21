import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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

  Future signIn(
    String username,
    String password,
  ) async {
    var uri = Uri.http(
      apiBaseUrl,
      kApiPath + 'auth/signin',
    );
    if (await _networkInfo.isConnected) {
      try {
        final response = await http.post(
          uri,
          body: {"username": username, "password": password},
        ).timeout(
          const Duration(seconds: 30),
        );

        if (response.statusCode == 201) {
          final jsonResponse = json.decode(response.body);
          log(' ${jsonResponse.toString()}');
          final auth = Auth.fromJson(jsonResponse);

          return right(auth);
        } else if (response.statusCode == 401) {
          return left(InvalidCredentialsFailure);
        } else if (response is TimeoutException) {
          return left(ServerFailure);
        } else {
          throw Exception('Failed to load the user');
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
