import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:trivia_educativa/data/local_db/cache_manager.dart';
import 'package:trivia_educativa/presentation/settings/settings_imports.dart';
import '../core/network_info/network_info.dart';
import '../core/network_info/network_info_impl.dart';
import '../data/datasources/nota_local_data_source.dart';
import '../data/nota_repository.dart';
import '../presentation/home/widgets/welcome_message/cubit/welcome_message_cubit.dart';
import '../presentation/nota_local/cubit/nota_local_cubit.dart';
import '../presentation/onboarding/onboarding_imports.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

FutureOr<void> initCore(GetIt sl) async {
  final _sharedPreferences = await SharedPreferences.getInstance();

  sl
    ..registerSingletonAsync<CacheManager>(
      () => CacheManager(sl).init(),
    )
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    )
    ..registerLazySingleton<OnboardingCubit>(
      () => OnboardingCubit(_sharedPreferences, sl),
    )
    ..registerLazySingleton<NotaLocalCubit>(
      () => NotaLocalCubit(_sharedPreferences, sl),
    )
    ..registerLazySingleton<SettingsController>(
        () => SettingsController(_sharedPreferences, sl))
    ..registerLazySingleton<WelcomeMessageCubit>(
      () => WelcomeMessageCubit(_sharedPreferences, sl),
    )
    ..registerLazySingleton<NotaLocalDataSource>(
      () => NotaLocalDataSource(
        sl,
      ),
    )
    ..registerLazySingleton<NotaRepository>(() => NotaRepository(
          sl,
        ))
    ..registerLazySingleton(() => SharedPreferences.getInstance());
}
