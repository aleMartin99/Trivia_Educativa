// import 'dart:io';
// import 'dart:math' show pi;

// import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import '../../home_page.dart';

// class PageStructure extends StatelessWidget {
//   String? title = "";
//   final Widget child;
//   final List<Widget> actions;
//   final Color backgroundColor;
//   final double elevation;

//   PageStructure({
//     required Key key,
//     this.title,
//     required this.child,
//     required this.actions,
//     required this.backgroundColor,
//     required this.elevation,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final angle = 180 * pi / 180;
//     final _currentPage =
//         context.select<MenuProvider, int>((provider) => provider.currentPage);
//     final container = Container(
//       color: Colors.grey[300],
//       child: Center(
//         child: Text(
//           //"${tr("current")}: ${HomeScreen.mainMenu[_currentPage].title}",
//           "",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//     final color = Theme.of(context).accentColor;
//     final style = TextStyle(color: color);

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           HomeScreen.mainMenu[_currentPage].title,
//         ),
//         leading: Transform.rotate(
//           angle: angle,
//           child: IconButton(
//             icon: Icon(
//               Icons.menu,
//             ),
//             onPressed: () {
//               AwesomeDrawerBar.of(context)?.toggle();
//             },
//           ),
//         ),
//         // trailingActions: actions,
//       ),
//       body: kIsWeb
//           ? container
//           : Platform.isAndroid
//               ? container
//               : SafeArea(
//                   child: container,
//                 ),
//     );
//   }
// }
