import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trivia_educativa/data/models/asignatura_model.dart';

import '../../../../core/app_icons.dart';

class AsignaturaCardWidget extends StatelessWidget {
  final Asignatura asignatura;

  final VoidCallback onTap;

  const AsignaturaCardWidget({
    Key? key,
    required this.asignatura,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              //todo coger de asignatura.config, si vacio de mi listado
              child: SizedBox(
                  height: 80,
                  child: CustomIconSVG(
                    //iconName:widget.icon
                    iconName: asignatura.icon,
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                Text(asignatura.descripcion,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryIconTheme.color)),
              ],
            ),
            Text(
              "${I10n.of(context).topics}: ${asignatura.temas.length}",
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
