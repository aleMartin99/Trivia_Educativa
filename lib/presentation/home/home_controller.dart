import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/data/models/models.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/repositories.dart';
import '../../main.dart';
import '../home/home_imports.dart';

class HomeController {
  final ValueNotifier<HomeState> stateNotifier =
      ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  List<Asignatura>? asignaturas;
  Estudiante? estudiante;
  List<NotaProv>? notas;
  var resp;

  final repository = HomeRepository(sl());

  Future getEstudiante(String cI, String token) async {
    state = HomeState.loading;
    final response = (await repository.findEstudianteByCI(cI, token));
    if (response.isRight()) {
      estudiante = ((response as Right).value as Estudiante);
      state = HomeState.estudLoaded;
      log('loaded estudiante byCI ${estudiante!.name}');
      log(state.name);
      return estudiante;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == ServerFailure) {
        state = HomeState.serverError;
      }
      if (resp == NoInternetConnectionFailure) {
        state = HomeState.notConnected;
      } else {
        state = HomeState.estudError;
      }
    }
  }

  Future getAsignaturas(int annoCurso, String token) async {
    state = HomeState.loading;
    final response = (await repository.findByAnno(annoCurso, token));
    if (response.isRight()) {
      asignaturas =
          ((response as Right).value as List<Asignatura>).cast<Asignatura>();
      state = HomeState.success;
      return asignaturas;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == NoInternetConnectionFailure) {
        state = HomeState.notConnected;
      }
      if (resp == ServerFailure) {
        state = HomeState.serverError;
      }
    } else {
      state = HomeState.error;
    }
  }

  Future getNotasProv(String cI, String token) async {
    state = HomeState.loading;
    final response = (await repository.getNotasProv(cI, token));
    if (response.isRight()) {
      notas = ((response as Right).value as List<NotaProv>).cast<NotaProv>();
      state = HomeState.notasLoaded;
      return notas;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == NoInternetConnectionFailure) {
        state = HomeState.notConnected;
      }
      if (resp == ServerFailure) {
        state = HomeState.serverError;
      }
    } else {
      state = HomeState.error;
    }
  }
}
