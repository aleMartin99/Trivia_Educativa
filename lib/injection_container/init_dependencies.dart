import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/core.dart';
import 'init_core.dart';

FutureOr<void> initDependencies(
  GetIt sl, {
  String apiBaseUrl = kApiAlePC,
}) async {
  await initCore(sl);
  await Hive.initFlutter();
}
