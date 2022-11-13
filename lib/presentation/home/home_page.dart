import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/home/widgets/appbar/menu_page.dart';
import 'dart:math' show pi;
import '../../main.dart';
import '../home/home_imports.dart';

var user = sl<User>();

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();

  void _loadData() async {
    //TODO implement subir nota local del offline
    await homeController.getEstudiante(user.ci);
    //TODO check si pasar el estudiante completo hasta challenge

    //TODO Checkear q no sea nulo desp de model modificar
    Estudiante estudiante = homeController.estudiante!;
    await homeController.getAsignaturas(estudiante.annoCurso);
  }

  @override
  initState() {
    Future.delayed(const Duration(seconds: 1), () {
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

      //TODO si no internet tira cerrar sesion pal login
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
      }
      // else if (homeController.state == HomeState.estudError) {
      //   QuickAlert.show(
      //     context: context,
      //     type: QuickAlertType.warning,
      //     title: 'Error con el estudiante',
      //     confirmBtnText: 'Ok',
      //     text: 'Al parecer esta x nicaragua',
      //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //     textColor: Theme.of(context).primaryIconTheme.color!,
      //     titleColor: Theme.of(context).primaryIconTheme.color!,
      //     confirmBtnColor: AppColors.purple,
      //   );

      //   homeController.state = HomeState.empty;
      // }
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
                      Text(
                        "Bienvenido!",
                        style: TextStyle(color: AppColors.white, fontSize: 24),
                        //  style: boldText(fSize: 40)
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 2.0),
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
                        'OK 🧠🚀', // style: boldText(fSize: 12)
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
//TODO pull to refresh implement from recarguita

    //TODO make validation for data to all pages like asignatura(home)

    //TODO validacion ara vacio como en niveles(revisar modelos con ?) o que no deje entrar
    //TODO add subtitulo que diga asignaturas
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBarWidget(
            user: user,
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
                                    //TODO hacer validaciones para cosas vacias
                                    cantTemas: asignatura.temas.length,
                                    onTap: () {
                                      (asignatura.temas.isEmpty ||
                                              asignatura.temas == null)
                                          ? QuickAlert.show(
                                              // barrierColor: Colors.red,
                                              context: context,
                                              type: QuickAlertType.warning,
                                              title: 'No existen temas',
                                              confirmBtnText: 'Ok',
                                              text:
                                                  'No hay temas disponibles por el momento',
                                              backgroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              textColor: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color!,
                                              titleColor: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color!,
                                              confirmBtnColor: AppColors.purple,
                                            )
                                          : Navigator.pushNamed(
                                              context, AppRoutes.temaRoute,
                                              arguments: TemaPageArgs(
                                                  idEstudiante: homeController
                                                      .estudiante!.id,
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

class HomeScreen extends StatefulWidget {
  //const HomeScreen({required this.user});

  //TODO move to another place the List<MyMenuItem>
  static List<MyMenuItem> mainMenu = [
    MyMenuItem("Inicio", Icons.home_filled, 0),
    MyMenuItem("Tabla de Posiciones", Icons.emoji_events, 1),
  ];

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _drawerController = AwesomeDrawerBarController();

  final int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return AwesomeDrawerBar(
      isRTL: false,
      controller: _drawerController,
      type: StyleState.scaleRight,
      menuScreen: MenuScreen(
        HomeScreen.mainMenu,
        callback: _updatePage,
        current: _currentPage,
        key: UniqueKey(),
        user: user,
      ),
      mainScreen: MainScreen(user: user),
      borderRadius: 24.0,
      showShadow: false,
      angle: 0.0,
      //backgroundColor: Colors.purple,
      //slideWidth: MediaQuery.of(context).size.width * .65,
      // openCurve: Curves.fastOutSlowIn,
      // closeCurve: Curves.bounceIn,
      slideWidth: MediaQuery.of(context).size.width * (false ? .45 : 0.65),
    );
  }

  void _updatePage(index) {
    Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index);
    _drawerController.toggle!();
  }
}

//TODO move
class MenuProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void updateCurrentPage(int index) {
    if (index != currentPage) {
      _currentPage = index;
      notifyListeners();
    }
  }
}

//TODO move
class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<DrawerState>? listenable =
        AwesomeDrawerBar.of(context)?.stateNotifier;
    const rtl = false;
    return ValueListenableBuilder<DrawerState>(
        valueListenable: listenable!,
        builder: (context, state, child) {
          return AbsorbPointer(
            absorbing: state != DrawerState.closed,
            child: child,
          );
        },
        child: GestureDetector(
          child: (context.select<MenuProvider, int>(
                      (provider) => provider.currentPage) ==
                  0)
              ? HomePage(

                  // key: UniqueKey(),
                  )
              //TODO implement escalafon page
              : WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.red,
                        title: Text(
                          Provider.of<MenuProvider>(context, listen: false)
                              ._currentPage
                              .toString(),
                        ),
                        leading: Transform.rotate(
                          angle: 180 * pi / 180,
                          child: IconButton(
                            icon: const Icon(
                              Icons.menu,
                            ),
                            onPressed: () {
                              AwesomeDrawerBar.of(context)?.toggle();
                            },
                          ),
                        ),
                        // trailingActions: actions,
                      ),
                      body: Text('data')))
          // onPanUpdate: (details) {
          //   if (details.delta.dx < 6 && !rtl || details.delta.dx < -6 && rtl) {
          //     AwesomeDrawerBar.of(context)?.toggle();
          //   }
          // },
          ,
        ));
  }
}
