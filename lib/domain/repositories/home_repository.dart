import 'dart:convert';
import 'dart:developer';

import 'package:trivia_educativa/core/error/failures.dart';
import 'package:trivia_educativa/data/models/asingatura_model.dart';
import 'package:trivia_educativa/data/models/nota_prov_model.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';

import '../../core/api_constants.dart';

// import 'package:fpdart/fpdart.dart';
// import 'package:recarguita/core/base-classes/remote_datasource_mixins/analize_error.dart';
// import 'package:recarguita/core/error/exceptions.dart';
// import 'package:recarguita/core/error/failures.dart';
// import 'package:recarguita/core/local_data_base/local_data_base.dart';
// import 'package:recarguita/core/local_data_base/local_data_base_contract.dart';
// import 'package:recarguita/core/network/network_info/network_info.dart';
// import 'package:recarguita/src/promo_notification/api/promo_notification_api.dart';
// import 'package:recarguita/src/promo_notification/models/promo_notification/promo_notification.dart';

// class PromoNotificationRepository with RequestErrorParser {
//   PromoNotificationRepository(
//     this._promoNotificationService,
//     this._networkInfo,
//     this._localDatabase,
//   );

//   final PromoNotificationService _promoNotificationService;
//   final LocalDatabase<PromoNotification> _localDatabase;
//   final NetworkInfo _networkInfo;

//   Future<Either<Failure, Iterable<PromoNotification>>>
//       getPromoNotifications() async {
//     if (await _networkInfo.isConnected) {
//       try {
//         final _response = await _promoNotificationService.getPromoCards();
//         final _body = _response.body;
//         final _statusCode = _body['code'];
//         if (_statusCode == 200) {
//           final _itemsJson = _body['items'] as List;
//           final _items = [
//             ...(_itemsJson).map((e) => PromoNotification.fromJson(e))
//           ]..sort((a, b) => a.priority!.compareTo(b.priority!));

//           log('Got this elements: $_items');

//           // Items that are really new and user hasn't seen before
//           final _newItems = <PromoNotification>[];

//           for (var element in _items) {
//             if (!(await _localDatabase.contains(element))) {
//               log('Local Database doesnt have the element $element');
//               _newItems.add(element);
//             }
//           }
//           log('Local database addding all elements $_newItems');
//           _localDatabase.addAll(_newItems);

//           return right(_newItems);
//         }
//         throw analyzeResponse(_response);
//       } on AuthenticationException catch (e) {
//         return left(
//           AuthenticationFailure(
//             message: e.toString(),
//           ),
//         );
//       } on ServerException catch (e) {
//         return left(
//           ServerFailure(
//             message: e.toString(),
//           ),
//         );
//       } catch (e) {
//         rethrow;
//         return left(
//           UnexpectedFailure(
//             message: e.toString(),
//           ),
//         );
//       }
//     } else {
//       return const Left(NoInternetConnectionFailure());
//     }
//   }
// }

// ReviewsRepository(this._networkInfo, this._apiService);

//   Future<Either<Failure, Unit>> sendFeedback(
//       FeedbackModel commentOrIssue) async {
//     log('sending feedback in repo');
//     if (await _networkInfo.isConnected) {
//       log('Is connected');
//       try {
//         final _res = (await _apiService.sendFeedback(commentOrIssue.toMap()));
//         log('Server response is ${_res.body}');
//         return _res.body!;
//       } catch (e) {
//         return Left(ServerFailure(message: e.toString()));
//       }
//     } else {
//       return const Left(NoInternetConnectionFailure());
//     }
//   }

class HomeRepository {
  //TODO check from recarguita como se inicializa el kApi const
  final String _baseUrl = kApiOldServer;
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

  Future<Either<Failure, List<Asignatura>>> getAsignaturas() async {
//
    var uri = Uri.http(
      _baseUrl,
      "asignaturas",
    );
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List;
        final asignaturas =
            jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
        //return jsonResponse.map((e) => Asignatura.fromJson(e)).toList();
        return right(asignaturas);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load Asingaturas');
      }
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
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
