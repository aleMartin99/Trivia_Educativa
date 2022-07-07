import 'dart:developer';
import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/data/models/user_model.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
import 'package:educational_quiz_app/presentation/challenge/widgets/next_button/next_button_widget.dart';
import 'package:educational_quiz_app/presentation/home/home_controller.dart';
import 'package:educational_quiz_app/presentation/login/widgets/alert_dialog.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _loadData() async {
    await controller.getUser();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  // final LoginController controller = LoginController();
  final controller = HomeController();
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
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: deviceSize.height / 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 185, width: 115,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bienvenido a \nEducational Quiz app!",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading40.copyWith(
                        color: settingsController.currentAppTheme.primaryColor,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: deviceSize.height * 0.04,
                      ),
                    ),
                    Text(
                      "Una aplicacion que mezcla la educación con diversión!",
                      style: AppTextStyles.body.copyWith(
                        color: settingsController.currentAppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              // const Expanded(
              //   child: SizedBox(
              //     height: 0,
              //   ),
              // ),
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
                  Expanded(
                    child: NextButtonWidget.purple(
                      label: "Login",
                      onTap: () async {
                        if (controller.users == null) {
                          showAlertDialog(context);
                        } else {
                          User user = controller.users!.last;
                          // user??
                          await Navigator.of(context).pushReplacementNamed(
                            AppRoutes.homeRoute,
                            arguments: HomePageArgs(user: user),
                          );
                        }

                        log("user ok!");
                      },
                    ),
                  ),

                  //           ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
