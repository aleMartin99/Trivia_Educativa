import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
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
    late final _onboardingAlreadySeen;
    return MultiProvider(providers: [
      BlocProvider(
        create: (context) => sl<OnboardingCubit>(),
      ),
      Provider<SettingsController>(
        //TODO ver recarguita cubit bloc provider onboarding
        create: (context) => sl<SettingsController>(),
        builder: (context, _) => MaterialApp(
          localizationsDelegates: I10n.localizationsDelegates,
          supportedLocales: I10n.supportedLocales,
          onGenerateTitle: (context) => I10n.of(context).appTitle,
          debugShowCheckedModeBanner: false,
          //TODO reverse login-onboarding condition
          initialRoute: (_onboardingAlreadySeen =
                  context.read<OnboardingCubit>().alreadySeen)
              ? '/onboarding'
              : '/login',

          onGenerateRoute: AppRouter.generateRoute,

          theme: context.watch<SettingsController>().currentAppTheme,

// theme: themeLight,
//           darkTheme: themeDark,
//           themeMode: EasyDynamicTheme.of(context).themeMode,
        ),
      )
    ]);
  }
}
