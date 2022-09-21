import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
        title: "Trivia Educativa",
        debugShowCheckedModeBanner: false,
        // home: SettingsPage(),
        initialRoute: "/login",
        onGenerateRoute: AppRouter.generateRoute,
        theme: context.watch<SettingsController>().currentAppTheme,
      ),
    );
  }
}
