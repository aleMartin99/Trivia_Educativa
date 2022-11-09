import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/core/core.dart';
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

  late final _onboardingAlreadySeen;

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final LoginController _loginController = LoginController();

//TODO I10n
//TODO text style (text from botones)

  @override
  void initState() {
    _onboardingAlreadySeen = context.read<OnboardingCubit>().alreadySeen;
    log('on boarding visto? ' + _onboardingAlreadySeen.toString());
    _loginController.stateNotifier.addListener(() {
      setState(() {});

      if (_loginController.state == LoginState.loggedIn) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Autenticación Exitosa',
            text: 'Bienvenido, ${_loginController.user!.name}',
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            textColor: Theme.of(context).primaryIconTheme.color!,
            titleColor: Theme.of(context).primaryIconTheme.color!,
            confirmBtnColor: AppColors.purple,
            confirmBtnText: 'Ok',
            onConfirmBtnTap: () async {
              User? user = _loginController.user;
              if (user != null) {
                await Navigator.of(context).pushReplacementNamed(
                  AppRoutes.homeRoute,
                  arguments: HomePageArgs(user: user),
                );
              }
            });
      } else if (_loginController.state == LoginState.error) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Ha ocurrido un error',
          text: 'Ha ocurrido un error inesperado',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
          confirmBtnText: 'Ok',
          //confirmBtnTextStyle: const TextStyle(color: AppColors.white),
        );
      } else if (_loginController.state == LoginState.unauthorized) {
        //TODO make Quick alert theme proof
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Credenciales Inválidas',
          text: 'Revise el usuario o la contraseña ',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
          confirmBtnText: 'Ok',
          //confirmBtnTextStyle: const TextStyle(color: AppColors.white),
        );
        _loginController.state = LoginState.empty;
      } else if (_loginController.state == LoginState.notConnected) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: 'No hay conexión a Internet',
          confirmBtnText: 'Ok',
          text:
              'Al parecer no tiene conexión a internet. Revise en los ajustes del teléfono',
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

  // showPopup({required bool isLogin}) {
  showLoginForm() {
    showLoginForm() {
      return Container(
        height: 400,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: AppGradients.linear,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Inicie sesión para continuar",
                  style: TextStyle(color: AppColors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                  // style: boldText(fSize: 30)
                ),
                // Text("This will ensure user data is saved to us",
                //     //   style: regulerText
                //     style: TextStyle(color: AppColors.white, fontSize: 20)),
                const SizedBox(height: 40),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: TextField(
                      controller: usernameController,
                      style: const TextStyle(color: AppColors.white),
                      // style: regulerText,
                      decoration: const InputDecoration(
                        hintText: "Nombre de usuario",
                        //hintStyle:
                        // regulerText
                      )),
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: TextField(
                      controller: passwordController,
                      style: const TextStyle(color: AppColors.white),
                      //  style: regulerText,
                      decoration: const InputDecoration(
                        hintText: "Contraseña",
                        // hintStyle: regulerText
                      )),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              title: 'Ha olvidado su contraseña?',
                              text:
                                  'Contacte con el administrador designado para que le restablezca la contraseñna',
                              confirmBtnText: 'Ok',
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              textColor:
                                  Theme.of(context).primaryIconTheme.color!,
                              titleColor:
                                  Theme.of(context).primaryIconTheme.color!,
                              confirmBtnColor: AppColors.purple,
                            );
                          },
                          child: const Text("Olvidó su contraseña?",
                              style: TextStyle(color: AppColors.white)
                              // regulerText
                              )),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ValueListenableBuilder<LoginState>(
                  valueListenable: _loginController.stateNotifier,
                  builder: (ctx, loadingValue, _) => Container(
                    child: _loginController.state == LoginState.loading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.green,
                            backgroundColor: Colors.black12,
                            //  valueColor: Colors.yellow,
                          ))
                        : GestureDetector(
                            onTap: () async {
                              await _loginController.signIn(
                                  usernameController.text,
                                  passwordController.text);

                              //  showPopup(isLogin: false);
                            },
                            child: Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.purple,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                    child: Text(
                                  "Continuar", // style: boldText(fSize: 12)
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ))),
                          ),
                  ),
                ),
                const SizedBox(height: 15),
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
            padding: EdgeInsets.symmetric(
              horizontal: deviceSize.width * 0.1,
              // vertical: deviceSize.height * 0.1,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: deviceSize.height / 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              label: "Iniciar sesión",
                              onTap: () {
                                showLoginForm();
                              }))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
