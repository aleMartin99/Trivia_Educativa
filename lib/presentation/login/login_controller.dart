import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/auth_model.dart';

import '../../domain/repositories/repositories.dart';
import 'package:trivia_educativa/data/models/models.dart';
import '../../main.dart';
import 'login_imports.dart';

class LoginController {
  final ValueNotifier<LoginState> stateNotifier =
      ValueNotifier<LoginState>(LoginState.empty);
  set state(LoginState state) => stateNotifier.value = state;
  LoginState get state => stateNotifier.value;

  late User user;
  late Auth auth;
  // ignore: prefer_typing_uninitialized_variables
  var resp;
  final repository = LoginRepository(sl());

  Future signIn(String username, String password) async {
    state = LoginState.loading;
    final response = (await repository.signIn(username, password));
    if (response.isRight()) {
      auth = ((response as Right).value as Auth);
      // user = auth.user;
      if (auth.user.rol != 'Estudiante') {
        state = LoginState.noPermits;
      } else {
        state = LoginState.loggedIn;
      }
      return auth;
    }

//TODO hacer estado timeout

    if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == NoInternetConnectionFailure) {
        state = LoginState.notConnected;
      } else if (resp == InvalidCredentialsFailure) {
        state = LoginState.unauthorized;
      } else if (resp == ServerFailure) {
        state = LoginState.serverUnreachable;
      } else {
        state = LoginState.error;
      }
    }
  }
}
