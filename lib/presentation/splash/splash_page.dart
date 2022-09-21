// import 'dart:developer';


// import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: (5)),
//       vsync: this,
//     );
//   }

//   void setTheme(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     if (prefs.containsKey("theme")) {
//       String? savedTheme = prefs.getString("theme");
//       log("saved theme: $savedTheme");
//       Provider.of<SettingsController>(context, listen: false)
//           .changeCurrentAppTheme(theme: savedTheme);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     setTheme(context);

//     // Future.delayed(const Duration(seconds: 2)).then(
//     //   (value) => Navigator.pushReplacementNamed(context, AppRoutes.loginRoute),
//     // );

//     return const Scaffold(
//       body: Text('LayoutCallback'),
//       // body: Lottie.asset(
//       //   'assets/lotties/quiz-splash.json',
//       //   controller: _controller,
//       //   height: MediaQuery.of(context).size.height * 1,
//       //   animate: true,
//       //   onLoaded: (composition) {
//       //     _controller
//       //       ..duration = composition.duration
//       //       ..forward().whenComplete(() => Navigator.pushReplacementNamed(
//       //             context,
//       //             AppRoutes.loginRoute,
//       //           ));
//       //   },
//       // ),
//     );
//   }
// }
