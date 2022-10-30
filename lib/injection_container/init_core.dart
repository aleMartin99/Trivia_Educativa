import 'dart:async';

import 'package:trivia_educativa/presentation/settings/settings_controller.dart';

import '../presentation/onboarding/cubit/onboarding_cubit.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

FutureOr<void> initCore(GetIt sl) async {
  final _sharedPreferences = await SharedPreferences.getInstance();

  sl
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
