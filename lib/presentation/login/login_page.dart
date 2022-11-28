import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/auth_model.dart';
import 'package:trivia_educativa/main.dart';
import 'package:trivia_educativa/presentation/login/widgets/password_widget.dart';
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
      return Container(
        alignment: Alignment.center,
        height: 400,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: AppGradients.linear,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        I10n.of(context).login,
                        //todo check textstyle font family
                        style: const TextStyle(
                            color: AppColors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<LoginState>(
                    valueListenable: _loginController.stateNotifier,
                    builder: (ctx, state, _) => Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: state == LoginState.unauthorized
                            ? Text(I10n.of(context).invalidCredentials,
                                //todo check textstyle font family
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ))
                            : (state == LoginState.noPermits)
                                ? Text(I10n.of(context).noPermissionsUser,
                                    //todo check textstyle font family
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 16,
                                    ))
                                : const Text(
                                    '',
                                    style: TextStyle(height: 0),
                                  ))),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    width: 400,
                    height: 65,
                    child: TextField(
                        controller: usernameController,
                        style: TextStyle(
                            color: Theme.of(context).primaryIconTheme.color,
                            fontSize: 16),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    width: 400,
                    height: 65,
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
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(I10n.of(context).forgottenPasswordButton,
                              //todo check textstyle font family
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              )),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<LoginState>(
                  valueListenable: _loginController.stateNotifier,
                  builder: (ctx, loadingValue, _) => SizedBox(
                    height: 48,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Container(
                                  width: 400,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: AppColors.purple,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    I10n.of(context).continueText,
                                    style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
    Size deviceSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: deviceSize.width * 0.1,
              right: deviceSize.width * 0.1,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: deviceSize.height / 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SizedBox(
                      height: 185,
                      width: 115,
                      child: Image.asset(AppImages.colorfulLogo),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${I10n.of(context).welcome} ${I10n.of(context).to} ${I10n.of(context).appTitle}",
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
                            maxHeight: deviceSize.height * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          I10n.of(context).appDescription,
                          textAlign: TextAlign.center,
                          //todo check textstyle font family
                          style: TextStyle(
                              fontFamily: 'PNRegular',
                              fontSize: 18,
                              color: Theme.of(context).primaryIconTheme.color),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
