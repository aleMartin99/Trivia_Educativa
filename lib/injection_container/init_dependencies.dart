import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/core.dart';
import 'init_core.dart';

FutureOr<void> initDependencies(
  GetIt sl, {
  String apiBaseUrl = kApiEmulatorBaseUrl,
}
    //String apiBaseUrl = kApiProductionBaseUrl,
    ) async {
  await initCore(sl);

  await Hive.initFlutter();

  //if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(NotaLocalAdapt());
  // await initAuth(sl, apiBaseUrl: apiBaseUrl, appVersion: appVersion);

  //  //Ensures to have a valid authentication state before the app runs.
  // await sl<AuthCubit>().refreshUserState();
}

// class NotaLocalAdapt extends TypeAdapter<NotaLocal> {
//   @override
//   final typeId = 1;

//   @override
//   NotaLocal read(BinaryReader reader) {
//     Map<String, dynamic> json = {};
//     var map = reader.readMap();
//     for (var element in map.entries) {
//       json[element.key.toString()] = element.value;
//     }
//     return NotaLocal.fromJson(json);
//   }

//   @override
//   void write(BinaryWriter writer, NotaLocal obj) {
//     writer.writeMap(obj.toJson());
//   }
// }
