import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/data/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../home/home_imports.dart';

class HomeController {
  final ValueNotifier<HomeState> stateNotifier =
      ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  List<Asignatura>? asignaturas;

  final repository = HomeRepository();

  Future getAsignaturas() async {
    state = HomeState.loading;
    final response = (await repository.getAsignaturas());
    if (response.isRight()) {
      asignaturas =
          ((response as Right).value as List<Asignatura>).cast<Asignatura>();
      state = HomeState.success;
      return asignaturas;
    } else {
      state = HomeState.error;
    }
  }
}
