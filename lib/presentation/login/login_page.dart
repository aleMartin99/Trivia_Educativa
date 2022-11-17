import 'package:flutter/material.dart';
//import 'package:fpdart/fpdart.dart';
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
  // final controller = LoginController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final _loginController = LoginController();

//TODO I10n

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
        Navigator.pop(context);
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
        _loginController.state = LoginState.empty;
      } else if (_loginController.state == LoginState.serverUnreachable) {
        Navigator.pop(context);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: 'Servidor no disponible',
          confirmBtnText: 'Ok',
          text: 'Al parecer el servidor no está disponible.',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );

        _loginController.state = LoginState.empty;
      } else if (_loginController.state == LoginState.notConnected) {
        Navigator.pop(context);
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

  // void badServer() async {
  //   var r = await Requests.get('https://google.com');
  //   // r.throwForStatus();
  //   // r.raiseForStatus();
  //   String body = r.content();
  //   log(r.statusCode.toString());
  //   log(body.toString());
  // }

  showLoginForm() {
    showLoginForm() {
      return Container(
        alignment: Alignment.center,
        //margin: EdgeInsets.all(0),
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
              //  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Iniciar sesión",
                        style: TextStyle(color: AppColors.white, fontSize: 24),
                        //textAlign: TextAlign.end,
                        // style: boldText(fSize: 30)
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<LoginState>(
                    valueListenable: _loginController.stateNotifier,
                    builder: (ctx, state, _) => Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: state == LoginState.unauthorized
                            ? const Text("* Credenciales inválidas",
                                //selectionColor: Colors.red,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ))
                            : (state == LoginState.noPermits)
                                ? const Text("* Usuario sin permisos",
                                    style: TextStyle(
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
                            // border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 3,
                                  color: AppColors.purple,
                                )),
                            hintText: "Nombre de usuario",
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
                          Navigator.pop(context);
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
                        child: const Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Text("Olvidó su contraseña?",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              )
                              // regulerText
                              ),
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
                                  child: const Center(
                                      child: Text(
                                    'Continuar', // style: boldText(fSize: 12)
                                    style: TextStyle(
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
              // top: deviceSize.width * 0.1,
              // vertical: deviceSize.height * 0.1,
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
                    //width: deviceSize.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${I10n.of(context).welcome} ${I10n.of(context).to} ${I10n.of(context).appTitle}",
                          //${_local.}
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
                          style: TextStyle(
                              fontFamily: 'PNRegular',
                              fontSize: 18,
                              color: Theme.of(context).primaryIconTheme.color
                              // fontWeight: FontWeight.w100,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: NextButtonWidget.purple(
                        label: "Iniciar sesión",
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
