import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/home/widgets/scoreboard/scoreboard_state.dart';
import '../../../../core/core.dart';
import '../../../../data/models/scoreboard.dart';
import '../../../../domain/repositories/scoreboard_repository.dart';
import '../../../../main.dart';

class ScoreBoardController {
  final ValueNotifier<ScoreBoardState> stateNotifier =
      ValueNotifier<ScoreBoardState>(ScoreBoardState.empty);
  set state(ScoreBoardState state) => stateNotifier.value = state;
  ScoreBoardState get state => stateNotifier.value;

  List<ScoreBoard>? scoreboardGeneral;
  List<ScoreBoard>? scoreboardCurso;

  var resp;

  final repository = ScoreBoardRepository(sl());

  Future getScoreGeneral(String token) async {
    state = ScoreBoardState.loading;
    final response = (await repository.promedioGlobal(token));
    if (response.isRight()) {
      scoreboardGeneral =
          ((response as Right).value as List<ScoreBoard>).cast<ScoreBoard>();

      state = ScoreBoardState.scoreGeneral;

      return scoreboardGeneral;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == ServerFailure) {
        state = ScoreBoardState.serverError;
      }
      if (resp == NoInternetConnectionFailure) {
        state = ScoreBoardState.notConnected;
      } else {
        state = ScoreBoardState.error;
      }
    }
  }

  Future getScorebyAnno(String token, int curso) async {
    state = ScoreBoardState.loading;
    final response = (await repository.promedioAnnoCurso(token, curso));
    if (response.isRight()) {
      scoreboardCurso =
          ((response as Right).value as List<ScoreBoard>).cast<ScoreBoard>();

      state = ScoreBoardState.scoreCurso;

      return scoreboardGeneral;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == ServerFailure) {
        state = ScoreBoardState.serverError;
      }
      if (resp == NoInternetConnectionFailure) {
        state = ScoreBoardState.notConnected;
      } else {
        state = ScoreBoardState.error;
      }
    }
  }
}
