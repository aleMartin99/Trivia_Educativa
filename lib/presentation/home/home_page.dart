import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quickalert/quickalert.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/models.dart';

import '../../data/models/auth_model.dart';
import '../../data/models/nota_local_model.dart';
import '../../domain/repositories/nota_repository.dart';
import '../../main.dart';
import '../challenge/challenge_controller.dart';
import '../home/home_imports.dart';
import 'widgets/welcome_message/cubit/welcome_message_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final challengeController = ChallengeController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var auth = sl<Auth>();
  late final NotaLocal notaLocal;

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _loadData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _loadData() async {
    homeController.state = HomeState.loading;
    await uploadNotaLocal().then(
        (value) => homeController.getEstudiante(auth.user.ci, auth.token));

    Estudiante estudiante = homeController.estudiante!;
    await homeController.getAsignaturas(estudiante.annoCurso, auth.token);
    await homeController.getNotasProv(auth.user.ci, auth.token);
  }

  Future uploadNotaLocal() async {
    var db = sl<NotaRepository>();
    List<NotaLocal> notas = await db.getNotas();

    if (notas.isNotEmpty) {
      log('notas local con valores');
      await challengeController
          .asignarNota(
              await challengeController.crearNota(notas[0].nota!, auth.token),
              notas[0].idAsignatura!,
              notas[0].idTema!,
              notas[0].idNivel!,
              notas[0].idEstudiante!,
              auth.token)
          .then((value) => db.deleteAllNotas());
    }
    homeController.state = HomeState.uploadedNotaLocal;
  }

  // ignore: unused_field
  late bool _welcomeMessageAlreadySeen;
  // late bool _pendingNota;
  @override
  initState() {
    _loadData();
    Future.delayed(const Duration(seconds: 1), () {
      (_welcomeMessageAlreadySeen =
              context.read<WelcomeMessageCubit>().alreadySeen)
          ? null
          : showWelcomeBox();
    });

    homeController.stateNotifier.addListener(() {
      setState(() {});
      if (homeController.state == HomeState.error) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error, //TODO I10n
          title: 'Ha ocurrido un error',
          text: 'Ha ocurrido un error inesperado',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
          confirmBtnText: 'Ok',
        );
        homeController.state = HomeState.empty;
      }
      if (homeController.state == HomeState.uploadedNotaLocal) {
        setState(() {
          homeController.state = HomeState.empty;
        });
      }
      if (homeController.state == HomeState.serverUnreachable) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          //TODO I10n
          title: 'Servidor no disponible',
          confirmBtnText: 'Ok',
          text: 'Al parecer el servidor no está disponible.',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );
        homeController.state = HomeState.empty;
      } else if (homeController.state == HomeState.notConnected) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          //TODO I10n
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
      }
    });
    super.initState();
  }

  showWelcomeBox() {
    showWelcomeBox() {
      return Container(
        alignment: Alignment.topLeft,
        height: 440,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: AppGradients.linear,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      //TODO I10n
                      Text(
                        "Bienvenido!",
                        style: TextStyle(color: AppColors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 2.0),
                  //TODO I10n
                  child: Text(
                    "Esta aplicación está destinada al apoyo del proceso educativo como alternativa a los métodos convencionales.\n\nAsí, los profesores podrán medir sus conocimientos y conocer su dominio acerca de ciertos temas y diferentes asignaturas.\n\nDiviértete y aprende!",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: AppColors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    context.read<WelcomeMessageCubit>().markAsViewed();
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 400,
                      height: 48,
                      decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        //TODO I10n
                        'OK', // style: boldText(fSize: 12)
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
    //TODO make validation for data to all pages like asignatura(home)

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBarWidget(),
          body: SmartRefresher(
            enablePullUp: false,
            physics: const BouncingScrollPhysics(),
            primary: false,
            header: const MaterialClassicHeader(
              color: AppColors.purple,
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            enablePullDown: true,
            child: (homeController.state == HomeState.loading)
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
                        'No hay asignaturas disponibles',
                        style: AppTextStyles.titleBold.copyWith(
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                      ))
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: GridView.count(
                            physics: const BouncingScrollPhysics(),
                            childAspectRatio: 1,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 12,
                            children: homeController.asignaturas!
                                .map((asignatura) => AsignaturaCardWidget(
                                      asignatura: asignatura,
                                      onTap: () {
                                        (asignatura.temas.isEmpty ||
                                                // ignore: unnecessary_null_comparison
                                                asignatura.temas == null)
                                            ? QuickAlert.show(
                                                context: context,
                                                //TODO I10n
                                                type: QuickAlertType.warning,
                                                title: 'No existen temas',
                                                confirmBtnText: 'Ok',
                                                text:
                                                    'No hay temas disponibles por el momento',
                                                backgroundColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
                                                textColor: Theme.of(context)
                                                    .primaryIconTheme
                                                    .color!,
                                                titleColor: Theme.of(context)
                                                    .primaryIconTheme
                                                    .color!,
                                                confirmBtnColor:
                                                    AppColors.purple,
                                              )
                                            : Navigator.pushNamed(
                                                context, AppRoutes.temaRoute,
                                                arguments: TemaPageArgs(
                                                  notas: homeController.notas!,
                                                  idEstudiante: homeController
                                                      .estudiante!.id,
                                                  asignatura: asignatura,
                                                  //temas: asignatura.temas
                                                ));
                                      },
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
          )),
    );
  }
}
