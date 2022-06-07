import 'package:educational_quiz_app/core/routers/routers.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

//ToDO bloqear orientacion
  @override
  Widget build(BuildContext context) {
    return Provider<SettingsController>(
      create: (context) => SettingsController(),
      builder: (context, _) => MaterialApp(
        title: "Educational Quiz App",
        debugShowCheckedModeBanner: false,
        // home: SettingsPage(),
        initialRoute: "/",
        onGenerateRoute: AppRouter.generateRoute,
        theme: context.watch<SettingsController>().currentAppTheme,
      ),
    );
  }
}
