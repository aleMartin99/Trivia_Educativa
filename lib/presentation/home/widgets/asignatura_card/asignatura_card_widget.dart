import 'package:trivia_educativa/core/app_theme.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../data/models/curso_model.dart';

class AsignaturaCardWidget extends StatelessWidget {
  final String nombre;
  final List<Curso> cursos;
  final int cantTemas;

  final VoidCallback onTap;

  const AsignaturaCardWidget({
    Key? key,
    required this.nombre,
    required this.cursos,
    required this.cantTemas,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        //foregroundDecoration:,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // boxShadow: Shadow(),
          border: const Border.fromBorderSide(
            BorderSide(
              strokeAlign: StrokeAlign.outside,
              color: AppColors.border,
            ),
          ),
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.backgroundColors(
              settingsController.currentAppTheme.brightness),
        ),
        child: Column(
          //TODO annadir curso correspondiente
          //TODO annadir cantidad items next page (temas)
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO put an ICON from LEO svg books
            Icon(
              Icons.list_alt,
              size: 36, color: settingsController.currentAppTheme.primaryColor,
              //color: ,
            ),
            Text(
              nombre,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.titleBold.copyWith(
                color: settingsController.currentAppTheme.primaryColor,
                //fontWeight: FontWeight.w600,
                //fontSize: 22
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${I10n.of(context).topics}: $cantTemas",
              //textAlign: TextAlign.end,
              style: AppTextStyles.body14.copyWith(
                color: settingsController.currentAppTheme.primaryColor,
                fontSize: 14,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
