import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AsignaturaCardWidget extends StatelessWidget {
  final String nombre;

  final int cantTemas;

  final VoidCallback onTap;

  const AsignaturaCardWidget({
    Key? key,
    required this.nombre,
    required this.cantTemas,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.backgroundColors(Theme.of(context).brightness),
        ),
        child: Column(
          //TODO annadir cantidad items next page (temas)
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 40,
                child: CustomIconSVG(
                  iconName: AppImages.icon_1,
                )),
            const SizedBox(
              height: 8,
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                Text(nombre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 21,
                        color: Theme.of(context).primaryIconTheme.color)),
              ],
            ),
            //fit: BoxFit.fitWidth,

            const SizedBox(
              height: 10,
            ),
            Text(
              "${I10n.of(context).topics}: $cantTemas",
              //textAlign: TextAlign.end,
              style: TextStyle(
                  fontFamily: 'PNRegular',
                  fontSize: 14,
                  color: Theme.of(context).primaryIconTheme.color
                  // fontWeight: FontWeight.w100,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
