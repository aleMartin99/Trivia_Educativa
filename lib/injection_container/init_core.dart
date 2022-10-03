import 'dart:async';

import '../presentation/onboarding/cubit/onboarding_cubit.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

FutureOr<void> initCore(GetIt sl) async {
  final _sharedPreferences = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton<OnboardingCubit>(
      //*change the parentesis
      () => OnboardingCubit(_sharedPreferences, sl),
    )
    // ..registerLazySingleton<AppTourCubit>(
    //   () => AppTourCubit(_sharedPreferences, sl()),
    // )
    ..registerLazySingleton(() => SharedPreferences.getInstance());
}
