import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' show pi;
import 'menu/menu_provider.dart';

class ScoreBoardPage extends StatefulWidget {
  const ScoreBoardPage({Key? key}) : super(key: key);

  @override
  State<ScoreBoardPage> createState() => _ScoreBoardPageState();
}

class _ScoreBoardPageState extends State<ScoreBoardPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.red,
              // title:
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
            body: Text('data')));
  }
}
