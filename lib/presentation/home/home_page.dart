import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:developer';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/models.dart';
import '../home/home_imports.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();

  void _loadData() async {
    //User? user = _loginController.user;
    await homeController.getEstudiante(widget.user.ci!);
    Estudiante estudiante = homeController.estudiante!;
    await homeController.getAsignaturas(estudiante.annoCurso);
  }

  @override
  initState() {
    Future.delayed(const Duration(microseconds: 1), () {
      //TODO Make only once like onboarding
      showWelcomeBox();
    });
    _loadData();
    homeController.stateNotifier.addListener(() {
      setState(() {});
      if (homeController.state == HomeState.error) {
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
      }
      // else if (homeController.state == HomeState.unauthorized) {
      //   //TODO make Quick alert theme proof
      //   QuickAlert.show(
      //     context: context,
      //     type: QuickAlertType.error,
      //     title: 'Credenciales Inválidas',
      //     text: 'Revise el usuario o la contraseña ',
      //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //     textColor: Theme.of(context).primaryIconTheme.color!,
      //     titleColor: Theme.of(context).primaryIconTheme.color!,
      //     confirmBtnColor: AppColors.purple,
      //     confirmBtnText: 'Ok',
      //     //confirmBtnTextStyle: const TextStyle(color: AppColors.white),
      //   );
      //   homeController.state = HomeState.empty;
      // }
      else if (homeController.state == HomeState.notConnected) {
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

        homeController.state = HomeState.empty;
        //TODO remove alert dialog
      } else if (homeController.state == HomeState.estudError) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: 'Error con el estudiante',
          confirmBtnText: 'Ok',
          text: 'Al parecer esta x nicaragua',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );

        homeController.state = HomeState.empty;
      }
    });
    // challengeController.stateNotifier.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  showWelcomeBox() {
    showWelcomeBox() {
      return Container(
        height: 350,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: AppGradients.linear,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close, color: Colors.white)),
                  ],
                ),
                const Text(
                  "Bienvenido!",
                  style: TextStyle(color: AppColors.white, fontSize: 30),
                  //  style: boldText(fSize: 40)
                ),
                const SizedBox(height: 30),
                const Text(
                  "Esta aplicación está destinada al apoyo del proceso educativo como alternativa a los métodos convencionales. Haciendo uso de esta app los profesores podrán medir sus conocimientos y conocer su dominio acerca de ciertos temas y diferentes asignaturas.\nDiviértete y aprende!.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.white),
                  //  style: regulerText
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        "OK 🧠🚀",
                        style: TextStyle(color: AppColors.white),
                        //   style: boldText(fSize: 12)
                      ))),
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
            content: showWelcomeBox(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
//TODO pull to refresh implement from recarguita

    //TODO make validation for data to all pages like asignatura(home)

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBarWidget(
            user: widget.user,
          ),
          //TODO check loading condition
          //! cuando carga el usuario pero se tumba el server se queda pegado el cargando, revisar y lanzar timeout y cartel
          body: (homeController.state == HomeState.loading)
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
                ))
              : (homeController.asignaturas == null ||
                      homeController.asignaturas!.isEmpty)
                  ?
                  //TODO I10n
                  Center(
                      child: Text(
                      //TODO change color, no se ve nada
                      'No hay asignaturas disponibles',
                      style: AppTextStyles.titleBold.copyWith(
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                    ))
                  //TODO make validation for data to all pages like asignatura(home) (asi)
                  //TODO add subtitulo que diga asignaturas
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GridView.count(
                          physics: const BouncingScrollPhysics(),
                          childAspectRatio: 1.11,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 16,
                          children: homeController.asignaturas!
                              .map((asignatura) => AsignaturaCardWidget(
                                    nombre: asignatura.descripcion,
                                    //TODO hacer validaciones para cosas vacias
                                    cantTemas: asignatura.temas.length,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.temaRoute,
                                          arguments: TemaPageArgs(
                                              idAsignatura: asignatura.id,
                                              temas: asignatura.temas));
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                    )),
    );
  }
}
