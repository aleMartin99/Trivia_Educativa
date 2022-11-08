import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:provider/provider.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/presentation/login/flutter_custom_modal_popup.dart';
import '../onboarding/onboarding_imports.dart';
import 'login_imports.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  // void _loadData() async {
  //   //TODO validar para que llame cuando ponga los campos
  //   await controller.getUser();
  //   log(controller.users!.last.username.toString());
  // }

  late final _onboardingAlreadySeen;
  @override
  void initState() {
    //_loadData();
    _onboardingAlreadySeen = context.read<OnboardingCubit>().alreadySeen;
    log('on boarding visto? ' + _onboardingAlreadySeen.toString());

    controller.stateNotifier.addListener(() {
      if (controller.state == LoginState.error) {
        //TODO remove the on tap error message and leave this when login sirva
        //TODO improv message
        Dialoger.showErrorDialog(
          context: context,
          title: I10n.of(context).error,
          description:
              "${I10n.of(context).problem_data}: \n${I10n.of(context).checkConnection}",

          //actions: [],
        );
      }
    });
    super.initState();
  }

  // final LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

//TOdo check login view
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  height: 185,
                  width: 115,
                  child: Image.asset(AppImages.colorfulLogo),
                ),
                SizedBox(
                  //width: deviceSize.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${I10n.of(context).welcome} ${I10n.of(context).to} \n${I10n.of(context).appTitle}",
                        //${_local.}

                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading40.copyWith(
                            color: Theme.of(context).primaryIconTheme.color,
                            fontSize: 45

                            //  settingsController.currentAppTheme.primaryColor,
                            ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: deviceSize.height * 0.04,
                        ),
                      ),
                      Text(
                        I10n.of(context).appDescription,
                        style: TextStyle(
                            fontFamily: 'PNRegular',
                            fontSize: 14,
                            color: Theme.of(context).primaryIconTheme.color
                            // fontWeight: FontWeight.w100,
                            ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: NextButtonWidget.purple(
                            label: I10n.of(context).login,
                            onTap: () async {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const CustomMenuModalPopupWidget(),
                                ),
                                //  arguments: HomePageArgs(user: user),
                              );
                            }))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
