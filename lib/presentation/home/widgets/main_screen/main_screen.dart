import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_educativa/presentation/home/widgets/scoreboard/scoreboard_page.dart';

import '../../home_imports.dart';
import '../menu/menu_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<DrawerState>? listenable =
        AwesomeDrawerBar.of(context)?.stateNotifier;
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
                ? const HomePage(

                    // key: UniqueKey(),
                    )
                : const ScoreBoardPage()));
  }
}
