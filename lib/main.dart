import 'package:flutter/material.dart';
import 'package:trivia_educativa/core/app_widget.dart';
import 'package:get_it/get_it.dart';

import 'core/api_constants.dart';
import 'injection_container/init_dependencies.dart';

final sl = GetIt.I;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies(
    sl,
    apiBaseUrl: kApiEmulatorBaseUrl,
    //*Check when authetication carlos
    // apiBaseUrl: kApiProductionBaseUrl,
  );

  runApp(const AppWidget());
}
