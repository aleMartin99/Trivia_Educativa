import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/core/theme/dark_theme.dart';
import 'package:trivia_educativa/core/theme/light_theme.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';
import '../presentation/home/widgets/menu/menu_provider.dart';
import '../presentation/home/widgets/welcome_message/cubit/welcome_message_cubit.dart';
import '../presentation/onboarding/cubit/onboarding_cubit.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

//ToDO fix the imports
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(providers: [
      BlocProvider(
        create: (context) => sl<OnboardingCubit>(),
      ),
      ChangeNotifierProvider(
        create: (_) => MenuProvider(),
      ),
      BlocProvider(
        create: (context) => sl<WelcomeMessageCubit>(),
      ),
      Provider<SettingsController>(
        create: (context) => sl<SettingsController>(),
        builder: (context, _) => RefreshConfiguration(
          enableLoadingWhenNoData: false,
          footerTriggerDistance: 15,
          dragSpeedRatio: 0.91,
          child: MaterialApp(
            localizationsDelegates: I10n.localizationsDelegates,
            supportedLocales: I10n.supportedLocales,
            onGenerateTitle: (context) => I10n.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            home: const AppRouter(),
            onGenerateRoute: AppRouter.generateRoute,
            theme: themeLight,
            darkTheme: themeDark,
            themeMode: EasyDynamicTheme.of(context).themeMode,
          ),
        ),
      ),
    ]);
  }
}
