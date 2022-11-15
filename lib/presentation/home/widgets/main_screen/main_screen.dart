import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' show pi;
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
                //TODO implement escalafon page
                : WillPopScope(
                    onWillPop: () async => false,
                    child: Scaffold(
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.red,
                          title: Text(
                            Provider.of<MenuProvider>(context, listen: false)
                                .currentPage
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
                        body: Text('data')))));
  }
}
