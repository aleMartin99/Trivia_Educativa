import 'dart:async';

import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import 'init_core.dart';

FutureOr<void> initDependencies(
  GetIt sl, {
  String apiBaseUrl = kApiEmulatorBaseUrl,
}
    //String apiBaseUrl = kApiProductionBaseUrl,
    ) async {
  await initCore(sl);
  // await initAuth(sl, apiBaseUrl: apiBaseUrl, appVersion: appVersion);

  //  //Ensures to have a valid authentication state before the app runs.
  // await sl<AuthCubit>().refreshUserState();
}
