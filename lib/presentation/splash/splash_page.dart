import 'dart:developer';

import 'package:educational_quiz_app/core/app_gradients.dart';
import 'package:educational_quiz_app/core/app_images.dart';
import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  void setTheme(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("theme")) {
      String? savedTheme = prefs.getString("theme");
      log("saved theme: $savedTheme");
      Provider.of<SettingsController>(context, listen: false)
          .changeCurrentAppTheme(theme: savedTheme);
    }
  }

  @override
  Widget build(BuildContext context) {
    setTheme(context);

    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Navigator.pushReplacementNamed(context, AppRoutes.loginRoute),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: Center(
          child: Image.asset(
            AppImages.colorfulLogo,
          ),
        ),
      ),
    );
  }
}
