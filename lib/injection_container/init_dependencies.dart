import 'dart:async';

import 'package:get_it/get_it.dart';

import '../core/api_constants.dart';
import 'init_core.dart';

FutureOr<void> initDependencies(
  GetIt sl, {
  String apiBaseUrl = kApiOldServer,
}
    //String apiBaseUrl = kApiProductionBaseUrl,
    ) async {
  await initCore(sl);

  //  //Ensures to have a valid authentication state before the app runs.
  // await sl<AuthCubit>().refreshUserState();
}
