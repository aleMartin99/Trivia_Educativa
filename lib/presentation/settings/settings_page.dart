import 'dart:developer';

import 'package:educational_quiz_app/data/models/user_model.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
// import 'package:educational_quiz_app/presentation/challenge/widgets/next_button/next_button_widget.dart';
// import 'package:educational_quiz_app/presentation/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/core/app_theme.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:educational_quiz_app/presentation/settings/widgets/settings_tile.dart';
import 'package:educational_quiz_app/presentation/shared/widgets/gradient_app_bar_widget.dart';

class SettingsPage extends StatefulWidget {
  final UserModel user;

  const SettingsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    SettingsController controller = Provider.of<SettingsController>(context);

    return Scaffold(
      backgroundColor: controller.currentAppTheme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        child: GradientAppBarWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(
                      context,
                      AppRoutes.homeRoute,
                      arguments: HomePageArgs(user: widget.user),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                ),
              ),
              Text(
                "Configuraciones",
                style: AppTextStyles.titleBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        preferredSize: const Size.fromHeight(250),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceSize.width * 0.1,
          vertical: deviceSize.height * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder(
              valueListenable: controller.themeNotifier,
              builder: (ctx, value, _) => SettingsTile(
                title: "Tema oscuro",
                switchValue: controller.currentAppTheme == AppTheme.darkTheme,
                onChanged: (v) {
                  log("entrou aqui");
                  controller.changeCurrentAppTheme();
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceSize.width * 0.1,
          vertical: deviceSize.height * 0.05,
        ),
        // child: Row(
        //   children: [
        //     Expanded(
        //       child: NextButtonWidget.purple(
        //         label: "Sair",
        //         onTap: () async {
        //           LoginController loginController = LoginController();
        //           bool signedOut =
        //               await loginController.signOut(context: context);

        //           if (signedOut) {
        //             Navigator.pushReplacementNamed(
        //                 context, AppRoutes.loginRoute);
        //           }
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
