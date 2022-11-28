import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/menu_item_model.dart';
import 'widgets/main_screen/main_screen.dart';
import 'widgets/menu/menu_provider.dart';
import 'widgets/menu/menu_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
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
    List<MyMenuItem> mainMenu = [
      MyMenuItem(I10n.of(context).homeMenuOption, Icons.home_filled, 0),
      MyMenuItem(I10n.of(context).scoreboardMenuOption, Icons.emoji_events, 1),
    ];
    return AwesomeDrawerBar(
      isRTL: false,
      controller: _drawerController,
      type: StyleState.scaleRight,
      menuScreen: MenuScreen(
        mainMenu,
        callback: _updatePage,
        current: _currentPage,
        key: UniqueKey(),
      ),
      mainScreen: const MainScreen(),
      borderRadius: 24.0,
      showShadow: false,
      angle: 0.0,
      // ignore: dead_code
      slideWidth: MediaQuery.of(context).size.width * (false ? .45 : 0.65),
    );
  }

  void _updatePage(index) {
    Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index);
    _drawerController.toggle!();
  }
}
