import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/data/models/auth_model.dart';

import '../../domain/repositories/repositories.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'login_imports.dart';

//TODO en el auth si es el user que devuelve es Estudiante acceso, si es profesor o administrador ERROR (no esta autorizado)

class LoginController {
  final ValueNotifier<LoginState> stateNotifier =
      ValueNotifier<LoginState>(LoginState.empty);
  set state(LoginState state) => stateNotifier.value = state;
  LoginState get state => stateNotifier.value;

  // final ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);
  // bool get isLoading => loadingNotifier.value;
  // set isLoading(bool value) => loadingNotifier.value = value;

  final ValueNotifier<bool> loginNotifier = ValueNotifier<bool>(false);
  bool get isLoggedIn => loginNotifier.value;
  set isLoggedIn(bool value) => loginNotifier.value = value;

  List<User>? users;
  User? user;
  Auth? auth;

  final repository = LoginRepository();

//TODO check connections when llamada api

  Future signIn(String username, String password) async {
    state = LoginState.loading;
    final response = (await repository.signIn(username, password));
    if (response.isRight()) {
      // resp = ((response as Right).value);
      auth = ((response as Right).value as Auth);
      user = auth!.user;
      state = LoginState.login;
      log('$user');
      return user;
    }
// implementar credenciales invalidas
    // else if (d){}

    else {
      state = LoginState.error;
    }
  }
}


 

//TODO se pide user, con ese user.carnetI(method comparar password para ) 




// import 'dart:developer';

// import 'package:educational_quiz_app/view/login/authentication.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class LoginController {
//   final ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);
//   bool get isLoading => loadingNotifier.value;
//   set isLoading(bool value) => loadingNotifier.value = value;

//   final ValueNotifier<bool> loginNotifier = ValueNotifier<bool>(false);
//   bool get isLoggedIn => loginNotifier.value;
//   set isLoggedIn(bool value) => loginNotifier.value = value;

//   String? name;
//   String? profileUrl;

//   Future<bool> signIn({required BuildContext context}) async {
//     isLoading = true;

//     try {
//       await Authentication.initializeFirebase();

//       User? user = await Authentication.signInWithGoogle(context);

//       if (user != null) {
//         name = user.displayName;
//         profileUrl = user.photoURL;
//       }

//       log("user name on authentication: ${user!.displayName}");

//       isLoggedIn = true;
//       isLoading = false;
//       return true;
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         Authentication.messageSnackBar(
//           message: "Um erro ocorreu. Tente novamente.",
//         ),
//       );
//     }

//     isLoading = false;
//     return false;
//   }

//   Future<bool> signOut({required BuildContext context}) async {
//     isLoading = true;

//     try {
//       Authentication.signOut(context: context);
//       name = null;
//       profileUrl = null;
//       isLoggedIn = false;
//       isLoading = false;
//       return true;
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         Authentication.messageSnackBar(
//           message: "Um erro ocorreu. Tente novamente.",
//         ),
//       );
//     }

//     isLoading = false;
//     return false;
//   }
// }
