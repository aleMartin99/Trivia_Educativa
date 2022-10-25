import 'package:flutter/foundation.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_state.dart';

import '../../data/models/nota_prov_model.dart';
import '../../domain/repositories/challenge_repository.dart';

//TODO change points system to amount of questions

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

  int qtdRightAnswers = 0;
  List<NotaProv>? notasProv;

  //TODO remove points with new server
  int puntos = 0;

  Future getNotasProv() async {
    state = ChallengeState.loading;

    notasProv = (await repository.getNotasProv()).cast<NotaProv>();

    state = ChallengeState.success;
    return notasProv;
  }

//todo move to challenge controller
//TODO annadir estudiante
  Future asignarNota(String idAsignatura, String idCurso, String idTema,
      String idNivel, String idNotaProv) async {
    state = ChallengeState.loading;

    repository.asignarNota(idAsignatura, idCurso, idTema, idNivel, idNotaProv);

    state = ChallengeState.success;
    // return nota;
  }

  void crearNota(int nota) async {
    state = ChallengeState.loading;

    repository.crearNota(nota);

    state = ChallengeState.success;
    // return nota;
  }
}
