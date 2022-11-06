import 'dart:convert';
import 'package:fpdart/fpdart.dart';

import 'package:trivia_educativa/data/models/models.dart';
import '../../core/core.dart';

import 'package:http/http.dart' as http;

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

class HomeRepository with RequestErrorParser {
  String apiBaseUrl = kApiOldServer;

  Future<Either<Failure, List<Asignatura>>> getAsignaturas() async {
//
    var uri = Uri.http(
      apiBaseUrl,
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
        //TODO I10n
        throw Exception('Failed to load Asingaturas');
      }
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }

    //return getJson(uri).then((value) => value);
  }
}
