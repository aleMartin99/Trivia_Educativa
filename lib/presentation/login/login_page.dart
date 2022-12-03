import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/auth_model.dart';
import 'package:trivia_educativa/main.dart';
import 'package:trivia_educativa/presentation/login/widgets/password_widget.dart';
import '../../core/theme/text_theme.dart';
import 'login_imports.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final _loginController = LoginController();

  void goHome() async {
    sl.pushNewScope();
    Auth auth = _loginController.auth;
    sl.registerSingleton<Auth>(auth);

    await Navigator.of(context).pushReplacementNamed(
      AppRoutes.homeScreen,
    );
  }

  @override
  void initState() {
    _loginController.stateNotifier.addListener(() {
      if (_loginController.state == LoginState.loggedIn) {
        goHome();
      }

      if (_loginController.state == LoginState.error) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }

        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: I10n.of(context).errorTitle,
          text: I10n.of(context).errorBody,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
          confirmBtnText: I10n.of(context).ok,
        );

        _loginController.state = LoginState.empty;
      } else if (_loginController.state == LoginState.serverUnreachable) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          title: I10n.of(context).serverUnavailableTitle,
          confirmBtnText: I10n.of(context).ok,
          text: I10n.of(context).serverUnavailableBody,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );

        _loginController.state = LoginState.empty;
      } else if (_loginController.state == LoginState.notConnected) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: I10n.of(context).noInternetConnectionTitle,
          confirmBtnText: I10n.of(context).ok,
          text: I10n.of(context).noInternetConnectionBody,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );

        _loginController.state = LoginState.empty;
      }
    });

    super.initState();
  }

  showLoginForm() {
    showLoginForm() {
      double height = MediaQuery.of(context).size.height / 100;
      double width = MediaQuery.of(context).size.width / 100;
      return Container(
        alignment: Alignment.center,
        height: height * 50,
        width: width * 83.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: AppGradients.linear,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: width * 1.9, right: width * 1.9, top: height * 1),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: height * 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        I10n.of(context).login,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontFamily: 'PNRegular',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<LoginState>(
                    valueListenable: _loginController.stateNotifier,
                    builder: (ctx, state, _) => Padding(
                        padding: EdgeInsets.only(left: width * 4.275),
                        child: state == LoginState.unauthorized
                            ? Text(I10n.of(context).invalidCredentials,
                                style: AppTextStyles.regularText16
                                    .copyWith(color: Colors.white))
                            : (state == LoginState.noPermits)
                                ? Text(I10n.of(context).noPermissionsUser,
                                    style: AppTextStyles.regularText16
                                        .copyWith(color: Colors.white))
                                : const Text(
                                    '',
                                    style: TextStyle(height: 0),
                                  ))),
                SizedBox(height: height * 2.5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 2.85),
                  child: SizedBox(
                    width: width * 73.3,
                    height: height * 8.125,
                    child: TextField(
                        controller: usernameController,
                        style: AppTextStyles.regularText16.copyWith(
                            color: Theme.of(context).primaryIconTheme.color),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: height * 1.875,
                                horizontal: width * 3.7),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 3,
                                  color: AppColors.purple,
                                )),
                            hintText: I10n.of(context).username,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    style: BorderStyle.solid)),
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            filled: true)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 2.85),
                  child: SizedBox(
                    width: width * 73.3,
                    height: height * 8.125,
                    child:
                        PasswordWidget(passwordController: passwordController),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.info,
                            title: I10n.of(context).forgottenPasswordTitle,
                            animType: QuickAlertAnimType.scale,
                            text: I10n.of(context).forgottenPasswordBody,
                            confirmBtnText: I10n.of(context).ok,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            textColor:
                                Theme.of(context).primaryIconTheme.color!,
                            titleColor:
                                Theme.of(context).primaryIconTheme.color!,
                            confirmBtnColor: AppColors.purple,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 2.85),
                          child: Text(I10n.of(context).forgottenPasswordButton,
                              style: AppTextStyles.regularText16.copyWith(
                                  color: Colors.white,
                                  decorationThickness: 1.5,
                                  decoration: TextDecoration.underline)),
                        )),
                  ],
                ),
                SizedBox(height: height * 2.5),
                ValueListenableBuilder<LoginState>(
                  valueListenable: _loginController.stateNotifier,
                  builder: (ctx, loadingValue, _) => SizedBox(
                    height: height * 6,
                    child: loadingValue == LoginState.loading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.green,
                            backgroundColor: Colors.black12,
                          ))
                        : GestureDetector(
                            onTap: () async {
                              //*Method to close keyboard
                              FocusScope.of(context).requestFocus(FocusNode());
                              await _loginController.signIn(
                                  usernameController.text,
                                  passwordController.text);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 2.85),
                              child: Container(
                                  width: width * 73.3,
                                  height: height * 6,
                                  decoration: BoxDecoration(
                                      color: AppColors.purple,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(I10n.of(context).continueText,
                                          style: const TextStyle(
                                              color: AppColors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'PNExtraBold')
                                          // fontWeight: FontWeight.bold),
                                          ))),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            contentPadding: EdgeInsets.zero,
            content: showLoginForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              left: width * 10,
              right: width * 10,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: height * 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 3.125),
                    child: SizedBox(
                      height: height * 22.88,
                      width: width * 30.26,
                      child: Image.asset(AppImages.colorfulLogo),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${I10n.of(context).welcome} ${I10n.of(context).to} \n${I10n.of(context).appTitle}",
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading40.copyWith(
                            fontSize: 38,
                            foreground: Paint()
                              ..shader = Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const LinearGradient(colors: <Color>[
                                      AppColors.lightPurple,
                                      AppColors.purple,
                                    ]).createShader(
                                      const Rect.fromLTWH(100, 0, 400, 100.0))
                                  : const LinearGradient(colors: <Color>[
                                      AppColors.black,
                                      AppColors.purple,
                                    ]).createShader(
                                      const Rect.fromLTWH(100, 0, 400, 100.0)),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: height * 4,
                          ),
                        ),
                        SizedBox(
                          height: height * 1.25,
                        ),
                        Text(
                          I10n.of(context).appDescription,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.regularText16.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 5),
                    child: NextButtonWidget.purple(
                        label: I10n.of(context).login,
                        onTap: () {
                          showLoginForm();
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
