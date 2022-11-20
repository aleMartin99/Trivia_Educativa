import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/app_icons.dart';

class TemaCardWidget extends StatelessWidget {
  final String nombre;
  final int cantNiveles;

  final VoidCallback onTap;

  const TemaCardWidget({
    Key? key,
    required this.nombre,
    required this.cantNiveles,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // border: const Border.fromBorderSide(
          //   BorderSide(
          //     color: AppColors.border,
          //   ),
          // ),
          color: AppTheme.backgroundColors(Theme.of(context).brightness),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 50,
                child: CustomIconSVG(
                  //TODO implement random
                  iconName: AppIcons.icon_1,
                )),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Text(
                nombre,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize:
                        21, //color: settingsController.currentAppTheme.primaryColor,
                    color: Theme.of(context).primaryIconTheme.color),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "${I10n.of(context).levels}: $cantNiveles",
                    style: const TextStyle(
                      fontFamily: 'PNRegular',
                      fontSize: 14,
                      // fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
