import 'dart:developer';

import 'package:trivia_educativa/data/models/user_model.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
// import 'package:educational_quiz_app/presentation/challenge/widgets/next_button/next_button_widget.dart';
// import 'package:educational_quiz_app/presentation/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_educativa/core/app_routes.dart';
import 'package:trivia_educativa/core/app_theme.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:trivia_educativa/presentation/settings/widgets/settings_tile.dart';
import 'package:trivia_educativa/presentation/shared/widgets/gradient_app_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  final User user;

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

    //static String? get defaultLocale => global_state.Intl.withLocale;
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
                    Navigator.pushReplacementNamed(
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
                I10n.of(context).settings,
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder(
              valueListenable: controller.themeNotifier,
              builder: (ctx, value, _) => SettingsTile(
                title: I10n.of(context).darkTheme,
                switchValue: controller.currentAppTheme == AppTheme.darkTheme,
                onChanged: (v) {
                  log("cambiar tema");
                  controller.changeCurrentAppTheme();
                  setState(() {});
                },
              ),
            ),
            //TODO take the app locale language
            //TODO I10n
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language:'),
              trailing: I10n.of(context).localeName == 'es'
                  ? Text('Espannol')
                  : Text('English'),
              subtitle: Text(I10n.of(context).localeName),
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
