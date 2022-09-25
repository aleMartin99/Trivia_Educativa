import 'package:intl/date_symbols.dart';
import 'package:intl/locale.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

//ToDO bloqear orientacion
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Provider<SettingsController>(
      create: (context) => SettingsController(),
      builder: (context, _) => MaterialApp(
        localizationsDelegates: I10n.localizationsDelegates,
        supportedLocales: I10n.supportedLocales,
        //locale: I10n.delegate.,

        // localizationsDelegates: const [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   Locale('en', ''), // English, no country code
        //   Locale('es', ''), // Spanish, no country code
        // ],
        //title: "Trivia Educativa",
        onGenerateTitle: (context) => I10n.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        // home: SettingsPage(),
        initialRoute: "/login",
        onGenerateRoute: AppRouter.generateRoute,
        theme: context.watch<SettingsController>().currentAppTheme,
      ),
    );
  }
}
