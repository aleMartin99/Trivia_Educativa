import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import '../../domain/repositories/repositories.dart';

//TODO change points system to amount of questions (porciento de correctas)
// 5 es 80 por ciento correcta
// 4 70
// 3 60

class ChallengeController {
  final repository = ChallengeRepository();

  final ValueNotifier<ChallengeState> stateNotifier =
      ValueNotifier<ChallengeState>(ChallengeState.empty);
  set state(ChallengeState state) => stateNotifier.value = state;
  ChallengeState get state => stateNotifier.value;

  final currentPageNotifier =
      ValueNotifier<int>(1); // notificador de pagina actual
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  int cantRightAnswers = 0;
  List<NotaProv>? notasProv;

  //TODO remove points with new server
  int puntos = 0;

//crear guarda en una variable
//  Future getAsignaturas() async {
//     state = HomeState.loading;
//     final response = (await repository.getAsignaturas());
//     if (response.isRight()) {
//       asignaturas =
//           ((response as Right).value as List<Asignatura>).cast<Asignatura>();
//       state = HomeState.success;
//       return asignaturas;
//     } else {
//       state = HomeState.error;
//     }
//   }

//TODO Quitar esto
//todo Check this method for contorller with right and left
  Future getNotasProv() async {
    state = ChallengeState.loading;
    final response = (await repository.getNotasProv());
    if (response.isRight()) {
      notasProv =
          ((response as Right).value as List<NotaProv>).cast<NotaProv>();
      state = ChallengeState.notasLoaded;
      return notasProv;
    } else {
      state = ChallengeState.error;
    }
  }

//TODO annadir id estudiante (ver orden)

  Future asignarNota(String idAsignatura, String idTema, String idNivel,
      String idNotaProv) async {
    state = ChallengeState.loading;

//TODO annadir id estudiante (ver orden)

    repository.asignarNota(idAsignatura, idTema, idNivel, idNotaProv);

    state = ChallengeState.notasAsignadas;
    // return nota;
  }

  void crearNota(int nota) async {
    state = ChallengeState.loading;

    repository.crearNota(nota);
//response para guardar el id y luego pasarselo
    state = ChallengeState.success;
    // return nota;
  }
}
