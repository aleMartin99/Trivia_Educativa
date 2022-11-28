import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/auth_model.dart';
import '../../../../main.dart';
import '../../home_imports.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' show pi;

// ignore: must_be_immutable
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({
    Key? key,
  }) : super(key: key);
  var auth = sl<Auth>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
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
                  trailing: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.backgroundColors(Brightness.dark)
                              : AppColors.lightPurple,
                      child: SizedBox(
                          width: width * 18,
                          height: width * 18,
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: FittedBox(
                                child: Icon(
                                  Icons.person,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.lightPurple
                                      : AppColors.grey,
                                ),
                              ),
                            ),
                          ))),
                )),
            const Align(
              alignment: Alignment(0.0, 1.0),
              child: ScoreCardWidget(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(250);
}
