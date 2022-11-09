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
  var resp;

  final repository = HomeRepository(sl());

  Future getEstudiante(String cI) async {
    state = HomeState.loading;
    final response = (await repository.findEstudianteByCI(cI));
    if (response.isRight()) {
      estudiante = ((response as Right).value as Estudiante);
      //user = auth!.user;
      state = HomeState.estudLoaded;
      log('loaded estudiante byCI ${estudiante!.name}');
      return estudiante;
    } else if (response.isLeft()) {
      resp = (response as Left).value;
      if (resp == NoInternetConnectionFailure) {
        state = HomeState.notConnected;
      } else {
        state = HomeState.estudError;
      }
    }
  }

  Future getAsignaturas(int annoCurso) async {
    state = HomeState.loading;
    final response = (await repository.findByAnno(annoCurso));
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
    } else {
      state = HomeState.error;
    }
  }
}
