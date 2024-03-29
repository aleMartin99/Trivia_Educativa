import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/repositories.dart';
import '../../main.dart';

class ChallengeController {
  final ValueNotifier<ChallengeState> stateNotifier =
      ValueNotifier<ChallengeState>(ChallengeState.empty);
  set state(ChallengeState state) => stateNotifier.value = state;
  ChallengeState get state => stateNotifier.value;

  final currentPageNotifier =
      ValueNotifier<int>(1); // notificador de pagina actual
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  int cantRightAnswers = 0;

  List<NotaProv>? notas;
  NotaProv? notaProv;
  // ignore: prefer_typing_uninitialized_variables
  var resp;

  final repository = ChallengeRepository(sl());

  Future asignarNota(String idNotaProv, String idAsignatura, String idTema,
      String idNivel, String idEstudiante, String token) async {
    state = ChallengeState.evaluating;

    final response = (await repository.addDatos(
        idNotaProv, idAsignatura, idTema, idNivel, idEstudiante, token));
    if (response.isRight()) {
      state = ChallengeState.notasAsignadas;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == NoInternetConnectionFailure) {
        state = ChallengeState.notConnected;
      } else if (resp == ServerFailure) {
        state = ChallengeState.serverUnreachable;
      } else {
        state = ChallengeState.errorAsigNotas;
      }
    }
    // return nota;
  }

  Future crearNota(int nota, String token) async {
    state = ChallengeState.evaluating;
    final response = (await repository.crearNota(nota, token));
    if (response.isRight()) {
      notaProv = ((response as Right).value as NotaProv);
      state = ChallengeState.success;
      return notaProv!.id;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == NoInternetConnectionFailure) {
        state = ChallengeState.notConnected;
      } else if (resp == ServerFailure) {
        state = ChallengeState.serverUnreachable;
      }
    } else {
      state = ChallengeState.error;
    }
  }
}
