import 'dart:developer';
//import 'package:fpdart/fpdart.dart';
import 'package:trivia_educativa/core/app_routes.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/user_model.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/presentation/challenge/widgets/next_button/next_button_widget.dart';
import 'package:trivia_educativa/presentation/login/login_controller.dart';

import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/dialogs.dart';
import '../onboarding/cubit/onboarding_cubit.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  void _loadData() async {
    //TODO validar para que llame cuando ponga los campos
    await controller.getUser();
    log(controller.users!.last.nombreUsuario.toString());
  }

  late final _onboardingAlreadySeen;
  @override
  void initState() {
    _loadData();
    _onboardingAlreadySeen = context.read<OnboardingCubit>().alreadySeen;
    log('on boarding visto? ' + _onboardingAlreadySeen.toString());

    controller.stateNotifier.addListener(() {
      //  setState(() {});

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
                            color: Theme.of(context).primaryIconTheme.color

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
                    //* check for login
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
                          label: I10n.of(context).login,
                          onTap: () async {
                            if (controller.users == null) {
                              _loadData();
                              //TODO remove  message when login sirva and validation in repository tiza
                              //     //TODO check for better message
                              //TODO In10
                              Dialoger.showErrorDialog(
                                  context: context,
                                  title: 'Error',
                                  description:
                                      'No se ha podido acceder a los usuarios');
                            }
                            // final _onboardingAlreadySeen =
                            //     context.read<OnboardingCubit>().alreadySeen;
                            // if (_onboardingAlreadySeen) {

                            //   if (controller.users == null) {

                            //     Dialoger.showErrorDialog(
                            //       context: context,
                            //       title: I10n.of(context).error,
                            //       description:
                            //           "${I10n.of(context).problem_data}: \n${I10n.of(context).checkConnection}",

                            //       //actions: [],
                            //     );
                            //     // showAlertDialog(context);
                            //   }
                            //    else {
                            // TODO check for user authentication
                            if (controller.users!.isNotEmpty) {
                              //   //TODO navigate to credentials screen
                              User user = controller.users!.last;
                              log("${I10n.of(context).welcome}  ${user.nombreUsuario}.");
                              //  user ??
                              await Navigator.of(context).pushReplacementNamed(
                                AppRoutes.homeRoute,
                                arguments: HomePageArgs(user: user),
                              );
                            }

                            // _loadData();

                            // }

//           return BlocListener<VersionControlCubit, VersionControlState>(
//             listener: (context, state) {
//               log('Version Controller in state: $state');
//               if (state is InvalidVersion) {
//                 showVersionErrorModal(context, state.version);
//               }
//             },
//             child: BlocBuilder<AuthCubit, AuthState>(
//               builder: (context, state) {
//                 Jiffy.locale(AppLocalizations.of(context)!.localeName);
// //*check Auth cubit, access token
//                 // if (state is Initial) {
//                 //   context.read<AuthCubit>().getAccessToken();
//                 //   return Container();
//                 // }
//                 // if (state is LoggedIn) {
//                 //   return RootComponent(
//                 //     initialIndex: widget.initialIndex,
//                 //   );
//                 // } else {
//                 //   return BlocProvider(
//                 //     create: (context) => sl<LandingCubit>(),
//                 //     child: const OnLandingPage(),
//                 //   );
//                 // }
//               },
//             ),
//           );
                          }
                          // else {
                          //   await Navigator.of(context).pushReplacementNamed(
                          //     AppRoutes.onboardingRoute,
                          //     // arguments: HomePageArgs(user: user),
                          //   );
                          // }
                          //},
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
      ),
    );
  }
}
