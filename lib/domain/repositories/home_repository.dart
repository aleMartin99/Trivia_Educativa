import 'dart:convert';
import 'dart:developer';

import 'package:educational_quiz_app/data/models/asingatura_model.dart';
import 'package:educational_quiz_app/data/models/nota_prov_model.dart';
import 'package:educational_quiz_app/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
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

  Future<List<User>> getUsers() async {
    var uri = Uri.http(
      _baseUrl,
      "usuarios",
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      final usuarios = jsonResponse.map((e) => User.fromJson(e)).toList();
      //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();

      return usuarios;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Users');
    }

    //return getJson(uri).then((value) => value);
  }

  Future<List<NotaProv>> getNotasProv() async {
    var uri = Uri.http(
      _baseUrl,
      "notas",
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      final notasProv = jsonResponse.map((e) => NotaProv.fromJson(e)).toList();
      return notasProv;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Notas');
    }
    //return getJson(uri).then((value) => value);
  }

  Future asignarNota(String idAsignatura, String idCurso, String idTema,
      String idNivel, String idNotaProv) async {
    var uri = Uri.http(
      _baseUrl,
      "notas" "/$idNotaProv",
    );

    try {
      final response = await http.put(uri, body: {
        "asignatura": idAsignatura,
        "curso": idCurso,
        "tema": idTema,
        "nivel": idNivel,
      });
      log(response.toString());
    } catch (ex) {
      throw Exception('Failed to asign a Nota');
    }
  }

  void crearNota(int nota) async {
    var uri = Uri.http(
      _baseUrl,
      "notas",
    );

    try {
      final response = await http.post(uri, body: {"nota": "$nota"});
      log(response.body);
    } catch (ex) {
      throw Exception('Failed to create a Nota');
    }
  }
  // if (response.statusCode == 200) {
  //   final jsonResponse = json.decode(response.body) as List;
  // //  final notasProv = jsonResponse.map((e) => NotaProv.fromJson(e)).toList();
  //  // return notasProv;
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load Notas');
  // }
  //return getJson(uri).then((value) => value);

  // Future<List<Profesor>> getProfesores() async {
  //   var uri = Uri.http(
  //     _baseUrl,
  //     "profesores",
  //   );
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body) as List;
  //     final profesores = jsonResponse.map((e) => Profesor.fromJson(e)).toList();
  //     //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
  //     return profesores;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load Profesores');
  //   }
  //   //return getJson(uri).then((value) => value);
  // }

  // Future<List<Tema>> getTemas() async {
  //   var uri = Uri.http(
  //     _baseUrl,
  //     "temas",
  //   );
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body) as List;
  //     final temas = jsonResponse.map((e) => Tema.fromJson(e)).toList();
  //     //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
  //     return temas;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load Temas');
  //   }
  //   //return getJson(uri).then((value) => value);
  // }

  // Future<List<Curso>> getCursos() async {
  //   var uri = Uri.http(
  //     _baseUrl,
  //     "curso",
  //   );
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body) as List;
  //     final cursos = jsonResponse.map((e) => Curso.fromJson(e)).toList();
  //     //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
  //     return cursos;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load Cursos');
  //   }
  //   //return getJson(uri).then((value) => value);
  // }

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
