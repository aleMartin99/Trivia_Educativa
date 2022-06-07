import 'dart:developer';

import 'package:educational_quiz_app/core/app_routes.dart';
//import 'package:dev_quiz/core/app_text_styles.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/routers/routers.dart';
import 'package:educational_quiz_app/view/challenge/widgets/next_button/next_button_widget.dart';
//import 'package:dev_quiz/view/home/home_page.dart';
// import 'package:educational_quiz_app/view/login/login_controller.dart';
import 'package:educational_quiz_app/view/settings/settings_controller.dart';
import 'package:educational_quiz_app/view/shared/models/user_model.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Scaffold(
      backgroundColor:
          settingsController.currentAppTheme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceSize.width * 0.1,
          vertical: deviceSize.height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              // color: Colors.red,
              child: Image.asset(
                settingsController.currentAppTheme.brightness ==
                        Brightness.light
                    ? AppImages.colorfulLogo
                    : AppImages.blackgroundLogo,
              ),
            ),
            SizedBox(
              width: deviceSize.width * 0.6,
              child: Column(
                children: [
                  Text(
                    "Bienvenido a \nEducational Quiz app!",
                    style: AppTextStyles.heading40.copyWith(
                      color: settingsController.currentAppTheme.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.02,
                  ),
                  Text(
                    "Una aplicacion que mezcla la educacion con diversion!",
                    style: AppTextStyles.body.copyWith(
                      color: settingsController.currentAppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                // ValueListenableBuilder<bool>(
                //   valueListenable: controller.loadingNotifier,
                //   builder: (ctx, loadingValue, _) => Expanded(
                //     child: controller.isLoading
                //         ? const Center(child: CircularProgressIndicator())
                //         : ValueListenableBuilder<bool>(
                //             valueListenable: controller.loginNotifier,
                //             builder: (ctx, loginValue, _) =>
                NextButtonWidget.purple(
                  label: "Login",
                  onTap: () async {
                    UserModel user = UserModel();
                    await Navigator.of(context).pushNamed(
                      AppRoutes.homeRoute,
                      arguments: HomePageArgs(user: user),
                    );

                    log("ok!");
                  },
                ),

                //           ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
