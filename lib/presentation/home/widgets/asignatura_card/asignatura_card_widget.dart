import 'package:trivia_educativa/core/app_theme.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AsignaturaCardWidget extends StatelessWidget {
  final String nombre;
  //final List<Curso> cursos;
  final int cantTemas;

  final VoidCallback onTap;

  const AsignaturaCardWidget({
    Key? key,
    required this.nombre,
    //required this.cursos,
    required this.cantTemas,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //foregroundDecoration:,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // boxShadow: Shadow(),
          // border: const Border.fromBorderSide(
          //   BorderSide(
          //     strokeAlign: StrokeAlign.outside,
          //     color: AppColors.border,
          //   ),
          // ),
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.backgroundColors(Theme.of(context).brightness),
        ),
        child: Column(
          //TODO annadir curso correspondiente
          //TODO annadir cantidad items next page (temas)
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 50,
                child: CustomIconSVG(
                  iconName: AppImages.icon_1,
                )),
            //TODO put an ICON from LEO svg books
            // Icon(
            //   Icons.list_alt,
            //   size: 36, color: settingsController.currentAppTheme.primaryColor,
            //   //color: ,
            // ),
            const SizedBox(
              height: 8,
            ),
            Text(nombre,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 21,
                    color: Theme.of(context).primaryIconTheme.color)),
            const SizedBox(
              height: 6,
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
