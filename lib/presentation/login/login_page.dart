import 'dart:developer';
//import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/core/app_routes.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/user_model.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/presentation/challenge/widgets/next_button/next_button_widget.dart';
import 'package:trivia_educativa/presentation/home/home_controller.dart';
import 'package:trivia_educativa/presentation/home/home_state.dart';
import 'package:trivia_educativa/presentation/login/widgets/alert_dialog.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _loadData() async {
    await controller.getUser();
  }

//TODO chequear initialization and use of applocalizations and _local
  // late AppLocalizations _local;

  // @override
  // void didChangeDependencies() {
  //   _local = AppLocalizations.of(context)!;
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    _loadData();
    controller.stateNotifier.addListener(() {
      setState(() {});
      if (controller.state == HomeState.error) showAlertDialog(context);
    });
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
                      "${I10n.of(context).welcome} ${I10n.of(context).to} \n${I10n.of(context).appTitle}",
                      //${_local.}

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
                      "${I10n.of(context).appDescription}",
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
                      label: "${I10n.of(context).login}",
                      onTap: () async {
                        if (controller.users == null) {
                          //TODO check for better message
                          showAlertDialog(context);
                        } else {
                          //TODO check for user authentication
                          User user = controller.users!.last;
                          log("${I10n.of(context).welcome} + ${user.nombreUsuario}.");
                          // user??
                          await Navigator.of(context).pushReplacementNamed(
                            AppRoutes.homeRoute,
                            arguments: HomePageArgs(user: user),
                          );
                        }
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
