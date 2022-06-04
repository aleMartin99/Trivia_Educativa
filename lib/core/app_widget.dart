import 'package:educational_quiz_app/routers/routers.dart';
import 'package:educational_quiz_app/view/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<SettingsController>(
      create: (context) => SettingsController(),
      builder: (context, _) => MaterialApp(
        title: "DevQuiz",
        debugShowCheckedModeBanner: false,
        // home: SettingsPage(),
        initialRoute: "/",
        onGenerateRoute: AppRouter.generateRoute,
        theme: context.watch<SettingsController>().currentAppTheme,
      ),
    );
  }
}
