import 'dart:developer';

import 'package:trivia_educativa/core/app_routes.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/nota_prov_model.dart';
import 'package:trivia_educativa/data/models/user_model.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/presentation/home/widgets/score_card/score_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/app_theme.dart';
import '../../../settings/settings_controller.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(250),
      child: SizedBox(
        height: 270,
        child: Stack(
          children: [
            Container(
                height: 161,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                  gradient: AppGradients.linear,
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(top: 60),
                  title: Text.rich(
                    TextSpan(
                      text: "${I10n.of(context).hello}, ",
                      style: AppTextStyles.title,
                      children: [
                        TextSpan(
                          text: user.username,
                          style: AppTextStyles.titleBold,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.settingsRoute,
                        arguments: SettingsPageArgs(user: user),
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //TODO check avatar color
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.backgroundColors(Brightness.dark)
                              : AppColors.lightPurple
                          //AppColors.lightPurple,

                          ),
                      // color: Colors.blue,
                      width: 75,
                      height: 75,
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.lightPurple
                              : AppColors.grey,
                          //size: 30,
                        ),
                      ),
                    ),
                  ),
                )),
            const Align(
              alignment: Alignment(0.0, 1.0),
              child: ScoreCardWidget(
                  //scorePercentage:
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(250);
}

// class AppBarWidget extends PreferredSize {
//   final User user;
//   final BuildContext context;

//   // static aprobados = cantAprobados(notasProv);

//   AppBarWidget({
//     Key? key,
//     required this.user,
//    // required this.notasProv,
//     required this.context,
//     //required this.settingsController
//   }) : super(
//           key: key,
//           preferredSize: const Size.fromHeight(250),
//           child: SizedBox(
//             height: 270,
//             child: Stack(
//               children: [
//                 Container(
//                     height: 161,
//                     width: MediaQuery.of(context).size.width,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                     ),
//                     decoration: const BoxDecoration(
//                       gradient: AppGradients.linear,
//                     ),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.only(top: 60),
//                       title: Text.rich(
//                         TextSpan(
//                           text: "${I10n.of(context).hello}, ",
//                           style: AppTextStyles.title,
//                           children: [
//                             TextSpan(
//                               text: user.nombreUsuario,
//                               style: AppTextStyles.titleBold,
//                             ),
//                           ],
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       trailing: GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(
//                             context,
//                             AppRoutes.settingsRoute,
//                             arguments: SettingsPageArgs(user: user),
//                           );
//                         },
//                         child: Container(
//                           clipBehavior: Clip.antiAlias,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               //TODO check avatar color
//                               color: Theme.of(context).brightness ==
//                                       Brightness.dark
//                                   ? AppTheme.backgroundColors(Brightness.dark)
//                                   : AppColors.lightPurple
//                               //AppColors.lightPurple,

//                               ),
//                           // color: Colors.blue,
//                           width: 75,
//                           height: 75,
//                           padding: const EdgeInsets.all(5),
//                           child: FittedBox(
//                             child: Icon(
//                               Icons.person,
//                               color: Theme.of(context).brightness ==
//                                       Brightness.dark
//                                   ? AppColors.lightPurple
//                                   : AppColors.grey,
//                               //size: 30,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: const Alignment(0.0, 1.0),
//                   //TODO esta entrando en null, revisar los valores
//                   child: ScoreCardWidget(
//                     //scorePercentage:
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ) {
//     log('SI lalaal');
//   }
// }
