import 'package:flutter/material.dart';
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
  final controller = HomeController();

  void _loadData() async {
    await controller.getAsignaturas();
  }

  @override
  initState() {
    _loadData();
    controller.stateNotifier.addListener(() {
      setState(() {});
      if (controller.state == HomeState.error) {
        Dialoger.showErrorDialog(
          context: context,
          title: 'Sucedió un error',
          description: 'Error cargando asignaturas en dialoger from recarguita',
        );
      }
    });
    // challengeController.stateNotifier.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(controller.toString());
    // SettingsController settingsController =
    //     Provider.of<SettingsController>(context);
//TODO pull to refresh implement from recarguita

    //TODO make validation for data to all pages like asignatura(home)

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //     settingsController.currentAppTheme.scaffoldBackgroundColor,
          appBar: AppBarWidget(
            //*cambie el usuario ya que lo cargo del login y lo paso x paramtros
            user: widget.user,
          ),

          //TODO check loading condition
          //! cuando carga el usuario pero se tumba el server se queda pegado el cargando, revisar y lanzar timeout y cartel

          body: (controller.state == HomeState.loading)
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
                ))
              : (controller.asignaturas == null ||
                      controller.asignaturas!.isEmpty)
                  ?
                  //TODO I10n
                  Center(
                      child: Text(
                      'No hay asignaturas disponibles',
                      style: AppTextStyles.titleBold.copyWith(
                          //color: settingsController.currentAppTheme.primaryColor,
                          //fontWeight: FontWeight.w600,
                          //fontSize: 22
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
                          childAspectRatio: 1.2,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 16,
                          children: controller.asignaturas!
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
