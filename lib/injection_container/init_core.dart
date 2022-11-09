import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:trivia_educativa/presentation/settings/settings_imports.dart';
import '../core/network_info/network_info.dart';
import '../core/network_info/network_info_impl.dart';
import '../presentation/onboarding/onboarding_imports.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

FutureOr<void> initCore(GetIt sl) async {
  final _sharedPreferences = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    )
    ..registerLazySingleton<OnboardingCubit>(
      () => OnboardingCubit(_sharedPreferences, sl),
    )
    ..registerLazySingleton<SettingsController>(
        () => SettingsController(_sharedPreferences, sl))

    // ..registerLazySingleton<AppTourCubit>(
    //   () => AppTourCubit(_sharedPreferences, sl()),
    // )
    ..registerLazySingleton(() => SharedPreferences.getInstance());
}
