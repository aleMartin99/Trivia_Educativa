// import 'package:flutter/material.dart';

// import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
// import 'package:provider/provider.dart';

// import 'package:trivia_educativa/core/core.dart';
// import 'package:trivia_educativa/data/models/models.dart';
// import '../shared/shared_imports.dart';
// import 'package:trivia_educativa/presentation/settings/settings_imports.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class SettingsPage extends StatefulWidget {
//   // final User user;

//   const SettingsPage({
//     Key? key,
//     // required this.user,
//   }) : super(key: key);

//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     Size deviceSize = MediaQuery.of(context).size;
//     SettingsController settingsController =
//         Provider.of<SettingsController>(context);
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: PreferredSize(
//         child: GradientAppBarWidget(
//           child: Align(
//             alignment: Alignment.bottomLeft,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 6),
//               child: Row(
//                 //crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   IconButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       alignment: Alignment.centerLeft,
//                       splashColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       padding: const EdgeInsets.all(0),
//                       icon: Icon(
//                         Icons.arrow_back,
//                         size: 25,
//                         color: Theme.of(context).iconTheme.color,
//                       )),
//                   Text(
//                     I10n.of(context).settings,
//                     style: AppTextStyles.titleBold.copyWith(
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         preferredSize: const Size.fromHeight(56),
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(
//           left: deviceSize.width * 0.1,
//           right: deviceSize.width * 0.1,
//           top: deviceSize.height * 0.05,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ValueListenableBuilder(
//                   valueListenable: settingsController.themeNotifier,
//                   builder: (ctx, value, _) => DedicatedListTile(
//                       title: Text(
//                         I10n.of(context).darkTheme,
//                         style: Theme.of(context).textTheme.headline4?.copyWith(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).primaryIconTheme.color),
//                       ),
//                       leading: Icon(
//                         Icons.dark_mode,
//                         color: Theme.of(context).primaryIconTheme.color,
//                       ),
//                       trailing: Switch.adaptive(
//                           activeColor: const Color(0xFF57B6E0),
//                           value: EasyDynamicTheme.of(context).themeMode ==
//                               ThemeMode.dark,
//                           onChanged: (v) {
//                             if (v) {
//                               EasyDynamicTheme.of(context).changeTheme(
//                                 dark: true,
//                                 dynamic: false,
//                               );
//                             } else {
//                               EasyDynamicTheme.of(context).changeTheme(
//                                 dynamic: true,
//                                 dark: false,
//                               );
//                             }
//                           })),
//                 ),
//                 DedicatedListTile(
//                   //TODO I10n
//                   onPressed: () async {
//                     const _acceptText = 'Aceptar';
//                     const _declineText = 'Cancelar';
//                     final _result = await Dialoger.showTwoChoicesDialog(
//                       //backgroundColor: Colors.red,
//                       acceptText: _acceptText,
//                       declineText: _declineText,
//                       context: context,
//                       title: '¿Estás seguro?',
//                       description:
//                           'Tendrá que volver a autenticarse para acceder al sistema',
//                     );

//                     if (_result == _acceptText) {
//                       Navigator.of(context).pushNamedAndRemoveUntil(
//                           '/login', (Route<dynamic> route) => false);
//                     }
//                   },
//                   leading: Icon(Icons.logout,
//                       color: Theme.of(context).primaryIconTheme.color),
//                   title: Text('Cerrar sesión',
//                       style: Theme.of(context).textTheme.headline4?.copyWith(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: Theme.of(context).primaryIconTheme.color
//                           //color: Theme.of(context).primaryColor,
//                           )),
//                 ),
//               ],
//             ),
//             const AppInformationWidget(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: deviceSize.width * 0.1,
//           vertical: deviceSize.height * 0.05,
//         ),
//       ),
//     );
//   }
// }
