import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/auth_model.dart';

import '../../domain/repositories/repositories.dart';
import 'package:trivia_educativa/data/models/models.dart';
import '../../main.dart';
import 'login_imports.dart';

//TODO en el auth si es el user que devuelve es Estudiante acceso, si es profesor o administrador ERROR (no esta autorizado)

class LoginController {
  final ValueNotifier<LoginState> stateNotifier =
      ValueNotifier<LoginState>(LoginState.empty);
  set state(LoginState state) => stateNotifier.value = state;
  LoginState get state => stateNotifier.value;

  // final ValueNotifier<bool> loginNotifier = ValueNotifier<bool>(false);
  // bool get isLoggedIn => loginNotifier.value;
  // set isLoggedIn(bool value) => loginNotifier.value = value;

  //late List<User> users;
  late User user;
  late Auth auth;
  var resp;
  final repository = LoginRepository(sl());

  Future signIn(String username, String password) async {
    state = LoginState.loading;
    final response = (await repository.signIn(username, password));
    if (response.isRight()) {
      //TODO rol estudiante check and state, specific dialog
      // resp = ((response as Right).value);
      auth = ((response as Right).value as Auth);
      user = auth.user;
      if (user.rol != 'Estudiante') {
        state = LoginState.noPermits;
      } else {
        state = LoginState.loggedIn;
      }

      log('$user');
      return user;
    }

//TODO hacer estado timeout

    if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == NoInternetConnectionFailure) {
        state = LoginState.notConnected;
      } else if (resp == InvalidCredentialsFailure) {
        state = LoginState.unauthorized;
      } else {
        state = LoginState.error;
      }
    }
  }
}
