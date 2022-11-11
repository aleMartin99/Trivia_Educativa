import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/repositories.dart';
import '../../main.dart';

//TODO change points system to amount of questions (porciento de correctas)
// 5 es 80 por ciento correcta
// 4 70
// 3 60

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

  NotaProv? notaProv;
  var resp;

  final repository = ChallengeRepository(sl());

//TODO annadir id estudiante (ver orden)

  void asignarNota(String idNotaProv, String idAsignatura, String idTema,
      String idNivel, String idEstudiante) async {
    state = ChallengeState.loading;

    final response = (await repository.addDatos(
        idNotaProv, idAsignatura, idTema, idNivel, idEstudiante));

    state = ChallengeState.notasAsignadas;
    if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == NoInternetConnectionFailure) {
        state = ChallengeState.notConnected;
      } else {
        state = ChallengeState.errorAsigNotas;
      }
    }
    // return nota;
  }

  Future crearNota(int nota) async {
    state = ChallengeState.loading;
    final response = (await repository.crearNota(nota));
    if (response.isRight()) {
      notaProv = ((response as Right).value as NotaProv);
      state = ChallengeState.success;
      return notaProv;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == NoInternetConnectionFailure) {
        state = ChallengeState.notConnected;
      }
    } else {
      state = ChallengeState.error;
    }
//TODO annadir response decode to return nota y take el id
  }
}
