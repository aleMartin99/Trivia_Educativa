// ignore_for_file: unused_field

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:quickalert/quickalert.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/nota_local/cubit/nota_local_cubit.dart';

import '../../data/datasources/nota_local_data_source.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/nota_local.dart';
import '../../data/nota_repository.dart';
import '../../main.dart';
import '../home/home_imports.dart';
import 'widgets/welcome_message/cubit/welcome_message_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kIdAsignaturaKey = '';
const String _kIdEstudianteKey = '';
const String _kIdNivelKey = '';
const String _kIdNotaProvKey = '';
const String _kIdTemaKey = '';
const String _pNota = '0';

class HomePage extends StatefulWidget {
// final SharedPreferences _sharedPreferences

  const HomePage({
    Key? key, //required this._sharedPreferences,
    //   Object object,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var auth = sl<Auth>();
  late final NotaLocal notaLocal;

//final _sharedPreferences = await SharedPreferences.getInstance();
  // void saveIdsFromNota(String idAsignatura, String idEstudiante, String idNivel,
  //     String idNotaProv, String idTema, int nota,// SharedPreferences a
  //     ) async {
  //   final _sharedPreferences = await SharedPreferences.getInstance();
  //   await _sharedPreferences.setString(_kIdAsignaturaKey, idAsignatura);
  //   await a.setString(_kIdEstudianteKey, idEstudiante);
  //   await a.setString(_kIdNivelKey, idNivel);
  //   await a.setString(_kIdNotaProvKey, idNotaProv);
  //   await a.setString(_kIdTemaKey, idTema);
  //   await a.setString(_pNota, nota.toString());
  // }

  // void saveNotaLocal ( NotaLocal notaLocal){

  // }

//* var one = int.parse('1');

  // NotaLocal loadNota(SharedPreferences a) {
  //   //final _sharedPreferences = await SharedPreferences.getInstance();

  //   notaLocal.idAsignatura = a.getString(
  //     _kIdAsignaturaKey,
  //   );
  //   notaLocal.idEstudiante = a.getString(
  //     _kIdEstudianteKey,
  //   );
  //   notaLocal.idNivel = a.getString(
  //     _kIdNivelKey,
  //   );
  //   notaLocal.idNotaProv = a.getString(
  //     _kIdNotaProvKey,
  //   );
  //   notaLocal.idTema = a.getString(
  //     _kIdTemaKey,
  //   );

  //   var notaParsedfromString = a.getString(_pNota);
  //   notaLocal.nota = int.parse(notaParsedfromString.toString());
  //   return notaLocal;
  // }

  void _onRefresh() async {
    // monitor network fetch

    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _loadData();
    //setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // _loadData();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _loadData() async {
    //TODO implement subir nota local del offline

    await homeController.getEstudiante(auth.user.ci, auth.token);

    Estudiante estudiante = homeController.estudiante!;
    await homeController.getAsignaturas(estudiante.annoCurso, auth.token);

    await homeController.getNotasProv(auth.user.ci, auth.token);
  }

  var db = sl<NotaRepository>();

  void dataLocal() async {
    //var box = Hive.box('notasBox');
    //NotaLocalDataSource db = NotaLocalDataSource(cacheManager: cacheManager);
    List<NotaLocal> a = await db.getNotas();
    NotaLocal nota = NotaLocal(
        idAsignatura: 'Mate',
        idEstudiante: '222aaID',
        idNivel: 'nivelID222',
        idNotaProv: 'notaPRov222ID',
        idTema: 'Hechosid222',
        nota: 2);

    await db.addNota(nota);
    // a = await db.getNotas();
    // db.deleteNota(2);
    //  if()
    print(a.length.toString());
    // await db.deleteAllNotas();
    //a = await db.getNotas();
    // print(a.length.toString());
    print(a.last.idAsignatura);
  }

  late bool _welcomeMessageAlreadySeen;
  late bool _pendingNota;
  @override
  initState() {
    dataLocal();
    // (_pendingNota =
    //           context.read<NotaLocalCubit>().notaPending)
    //       ?
    //       : null;
    //TODO comprobar que no hay nota local, si hay, mandar a server y limpiar bd
    Future.delayed(const Duration(seconds: 1), () {
      (_welcomeMessageAlreadySeen =
              context.read<WelcomeMessageCubit>().alreadySeen)
          ? null
          : showWelcomeBox();
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
      //TODO change message
      if (homeController.state == HomeState.serverError) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Se exploto el servr',
          text: 'Explotao, 500 papu',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
          confirmBtnText: 'Ok',
        );
        homeController.state = HomeState.empty;
      } else if (homeController.state == HomeState.notConnected) {
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
                    //  style: regulerText
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

          //! cuando carga el usuario pero se tumba el server se queda pegado el cargando, revisar y lanzar timeout y cartel
          body: SmartRefresher(
            enablePullUp: false,
            physics: const BouncingScrollPhysics(),
            primary: false,
            //st
            //footer: ,
            header: const MaterialClassicHeader(
              // distance: 40,
              //backgroundColor: Colors.white,
              color: AppColors.purple,
            ),
            //header: WaterDropHeader(),
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
                            childAspectRatio: 1.11,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 16,
                            children: homeController.asignaturas!
                                .map((asignatura) => AsignaturaCardWidget(
                                      nombre: asignatura.descripcion,
                                      cantTemas: asignatura.temas.length,
                                      onTap: () {
                                        (asignatura.temas.isEmpty ||
                                                asignatura.temas == null)
                                            ? QuickAlert.show(
                                                // barrierColor: Colors.red,
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
