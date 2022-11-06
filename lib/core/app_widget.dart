import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/core/theme/dark_theme.dart';
import 'package:trivia_educativa/core/theme/light_theme.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';
import '../presentation/onboarding/cubit/onboarding_cubit.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

//ToDO fix the imports
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // ignore: unused_local_variable
    bool _onboardingAlreadySeen;
    return MultiProvider(providers: [
      //  BlocProvider(
      //       create: (context) => sl<AuthCubit>(),
      //     ),
      BlocProvider(
        create: (context) => sl<OnboardingCubit>(),
      ),
      Provider<SettingsController>(
        create: (context) => sl<SettingsController>(),
        builder: (context, _) => MaterialApp(
          localizationsDelegates: I10n.localizationsDelegates,
          supportedLocales: I10n.supportedLocales,
          onGenerateTitle: (context) => I10n.of(context).appTitle,
          debugShowCheckedModeBanner: false,
          initialRoute: (_onboardingAlreadySeen =
                  context.read<OnboardingCubit>().alreadySeen)
              ? '/login'
              : '/onboarding',
          onGenerateRoute: AppRouter.generateRoute,
          theme: themeLight,
          darkTheme: themeDark,
          themeMode: EasyDynamicTheme.of(context).themeMode,
        ),
      ),
      // BlocProvider(
      //       create: (context) => sl<AppTourCubit>(),
      //     ),
    ]);
  }
}
