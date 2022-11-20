import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/menu_item.dart';
import 'widgets/main_screen/main_screen.dart';
import 'widgets/menu/menu_provider.dart';
import 'widgets/menu/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  static List<MyMenuItem> mainMenu = [
    //TODO I10n
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
//TODO check marcar selected from other code
  @override
  Widget build(BuildContext context) {
    return AwesomeDrawerBar(
      isRTL: false,
      shadowColor: Colors.red,
      controller: _drawerController,
      type: StyleState.scaleRight,
      menuScreen: MenuScreen(
        HomeScreen.mainMenu,
        callback: _updatePage,
        current: _currentPage,
        key: UniqueKey(),
      ),
      mainScreen: const MainScreen(),
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
