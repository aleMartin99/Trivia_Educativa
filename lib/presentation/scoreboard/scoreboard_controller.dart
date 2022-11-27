import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/presentation/scoreboard/scoreboard_state.dart';
import '../../core/core.dart';
import '../../data/models/scoreboard_item_model.dart';
import '../../domain/repositories/scoreboard_repository.dart';
import '../../main.dart';

class ScoreBoardController {
  final ValueNotifier<ScoreBoardState> stateNotifier =
      ValueNotifier<ScoreBoardState>(ScoreBoardState.empty);
  set state(ScoreBoardState state) => stateNotifier.value = state;
  ScoreBoardState get state => stateNotifier.value;

  List<ScoreBoardItem>? scoreboardGeneral;
  List<ScoreBoardItem>? scoreboardCurso;

  // ignore: prefer_typing_uninitialized_variables
  var resp;
  final repository = ScoreBoardRepository(sl());

  Future getScoreGeneral(String token) async {
    state = ScoreBoardState.loadingGeneral;
    final response = (await repository.promedioGlobal(token));
    if (response.isRight()) {
      scoreboardGeneral = ((response as Right).value as List<ScoreBoardItem>)
          .cast<ScoreBoardItem>();

      state = ScoreBoardState.scoreGeneral;
      return scoreboardGeneral;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == ServerFailure) {
        state = ScoreBoardState.serverUnreachable;
      } else if (resp == NoInternetConnectionFailure) {
        state = ScoreBoardState.notConnected;
      } else if (resp == ServerFailure) {
        state = ScoreBoardState.serverUnreachable;
      } else {
        state = ScoreBoardState.error;
      }
    }
  }

  Future getScorebyAnno(String token, int curso) async {
    state = ScoreBoardState.loadingbyAnno;
    final response = (await repository.promedioAnnoCurso(token, curso));
    if (response.isRight()) {
      scoreboardCurso = ((response as Right).value as List<ScoreBoardItem>)
          .cast<ScoreBoardItem>();

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
