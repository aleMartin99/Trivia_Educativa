import 'dart:convert';

import 'package:educational_quiz_app/data/models/asingatura_model.dart';
import 'package:educational_quiz_app/data/models/profesor_model.dart';
import 'package:educational_quiz_app/data/models/quiz_model.dart';
import 'package:educational_quiz_app/data/models/tema_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TemaRepository {
  final String _baseUrl = '10.0.2.2:3000';
  // Future<UserModel> getUser() async {
  //   // o rootBundle vai acessar os arquivos
  //   final response = await rootBundle.loadString("lib/data/database/user.json");
  //   // convertendo de json para usermodel
  //   final user = UserModel.fromJson(response);
  //   return user;
  // }

  // Future<List<QuizModel>> getQuizzes() async {
  //   //acessando os arquivos
  //   final response =
  //       await rootBundle.loadString("lib/data/database/quizzes.json");
  //   //convertendo o json para uma lista, ja que eh uma
  //   final list = json.decode(response) as List;
  //   //convertendo de mapa para quiz model
  //   final quizzes = list.map((quizMap) => QuizModel.fromMap(quizMap)).toList();
  //   return quizzes;
  // }

//TODO fix this repository shit
  Future<List<Asignatura>> getAsignaturas() async {
    var uri = Uri.http(
      _baseUrl,
      "asignaturas",
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      final asignaturas =
          jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
      //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
      return asignaturas;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Asingaturas');
    }
    //return getJson(uri).then((value) => value);
  }

  Future<List<Profesor>> getProfesores() async {
    var uri = Uri.http(
      _baseUrl,
      "profesores",
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      final profesores = jsonResponse.map((e) => Profesor.fromJson(e)).toList();
      //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
      return profesores;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Profesores');
    }
    //return getJson(uri).then((value) => value);
  }

  Future<List<Tema>> getTemas() async {
    var uri = Uri.http(
      _baseUrl,
      "temas",
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      final temas = jsonResponse.map((e) => Tema.fromJson(e)).toList();
      //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
      return temas;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Temas');
    }
    //return getJson(uri).then((value) => value);
  }

  // Future<List<Nivel>> getNiveles() async {
  //   var uri = Uri.http(
  //     _baseUrl,
  //     "niveles",
  //   );
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body) as List;
  //     final niveles = jsonResponse.map((e) => Nivel.fromJson(e)).toList();
  //     //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
  //     return niveles;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load Temas');
  //   }
  //   //return getJson(uri).then((value) => value);
  // }
}
