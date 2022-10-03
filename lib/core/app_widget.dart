import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_educativa/core/app_routes.dart';
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

//ToDO bloqear orientacion
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(providers: [
      BlocProvider(
        create: (context) => sl<OnboardingCubit>(),
      ),
      Provider<SettingsController>(
        //TODO ver recarguita cubit bloc provider onboarding
        create: (context) => SettingsController(),
        builder: (context, _) => MaterialApp(
          localizationsDelegates: I10n.localizationsDelegates,
          supportedLocales: I10n.supportedLocales,

          //title: "Trivia Educativa",
          onGenerateTitle: (context) => I10n.of(context).appTitle,
          debugShowCheckedModeBanner: false,
          // home: SettingsPage(),
          initialRoute: '/login',
          onGenerateRoute: AppRouter.generateRoute,
          theme: context.watch<SettingsController>().currentAppTheme,
        ),
      )
    ]);
  }
}
