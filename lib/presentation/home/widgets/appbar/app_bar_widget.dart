import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/auth_model.dart';
import '../../../../main.dart';
import '../../home_imports.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' show pi;

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({
    Key? key,
    //  required this.user,
  }) : super(key: key);
  // final User user;
  var auth = sl<Auth>();
  @override
  Widget build(BuildContext context) {
    const angle = 180 * pi / 180;
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
                          text: auth.user.username,
                          style: AppTextStyles.titleBold,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  //TODO make app bar for escalafon with this
                  leading: Transform.rotate(
                    angle: angle,
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        AwesomeDrawerBar.of(context)?.toggle();
                      },
                    ),
                  ),
                  trailing: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
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
                )),
            const Align(
              alignment: Alignment(0.0, 1.0),
              child: ScoreCardWidget(
                  // scorePercentage:
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
