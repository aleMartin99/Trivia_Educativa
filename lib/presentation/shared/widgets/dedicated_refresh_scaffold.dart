import 'dart:io';

import 'package:flutter/material.dart';

class DedicatedScaffold extends StatelessWidget {
  const DedicatedScaffold({
    Key? key,
    this.scaffoldKey,
    required this.body,
    this.appBar,
    this.bottomAppBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.floatingActionButtonLocation,
    this.bottomSafe = false,
    this.tapToExitKeyboard = true,
    this.resizeToAvoidBottomInset = false,
  }) : super(key: key);

  final Widget? bottomAppBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final bool bottomSafe;
  final bool tapToExitKeyboard;
  final Key? scaffoldKey;
  final bool resizeToAvoidBottomInset;
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return SafeArea(
        top: false,
        right: false,
        left: false,
        bottom: bottomSafe,
        child: Builder(builder: (context) {
          final scaffold = Scaffold(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            key: scaffoldKey,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButton: floatingActionButton,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            extendBodyBehindAppBar: true,
            extendBody: true,
            bottomNavigationBar: bottomAppBar,
            appBar: appBar,
            body: body,
          );
          if (tapToExitKeyboard) {
            return GestureDetector(
              onTap: tapToExitKeyboard
                  ? () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  : null,
              child: scaffold,
            );
          } else {
            return scaffold;
          }
        }),
      );
    }
    return GestureDetector(
      onTap: tapToExitKeyboard
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          : null,
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        bottom: bottomSafe,
        child: Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          key: scaffoldKey,
          bottomNavigationBar: bottomAppBar,
          appBar: appBar,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButton: floatingActionButton,
          extendBody: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: body,
        ),
      ),
    );
  }
}
