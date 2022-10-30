import 'dart:developer';

import 'package:trivia_educativa/core/app_routes.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/user_model.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_controller.dart';
import 'package:trivia_educativa/presentation/home/home_controller.dart';
import 'package:trivia_educativa/presentation/home/home_state.dart';
import 'package:trivia_educativa/presentation/home/widgets/appbar/app_bar_widget.dart';
import 'package:trivia_educativa/presentation/home/widgets/asignatura_card/asignatura_card_widget.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/dialogs.dart';
import '../challenge/challenge_state.dart';

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
  //final challengeController = ChallengeController();
  // final cont

// Widget build(BuildContext context) {
//   return RaisedButton(
//     onPressed: () {
//       // as performant as the previous solution, but resilient to refactoring
//       context.read<Counter>().increment(),
//     },
//   );
// }

  void _loadData() async {
    //await controller.getNotasProv();
    await controller.getAsignaturas();
    // await challengeController.getNotasProv();

    //log(challengeController.notasProv!.last.nota.toString());
    //  await controller.getProfesores();
    // await controller.getCursos();
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
                                    cantTemas:
                                        asignatura.cursos.last.temas.length,
                                    cursos: asignatura.cursos,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.temaRoute,
                                          arguments: TemaPageArgs(
                                              idAsignatura: asignatura.id,
                                              idCurso:
                                                  asignatura.cursos.last.id,
                                              temas: asignatura
                                                  .cursos.last.temas));
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                    )),
    );
  }
}
