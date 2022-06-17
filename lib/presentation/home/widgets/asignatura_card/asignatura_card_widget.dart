import 'package:educational_quiz_app/core/app_theme.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: const Border.fromBorderSide(
            BorderSide(
              color: AppColors.border,
            ),
          ),
          color: AppTheme.backgroundColors(
              settingsController.currentAppTheme.brightness),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(
                AppImages.blocks,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading15.copyWith(
                        color: settingsController.currentAppTheme.primaryColor,
                      ),
                    ),
                    Text(
                      //*cambiar este jpoin, me interesa solamente el nombre del curso
                      cursos.join(),
                      //textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body11.copyWith(
                        color: settingsController.currentAppTheme.primaryColor,
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Temas:$cantTemas",
                    style: AppTextStyles.body11.copyWith(
                      color: settingsController.currentAppTheme.primaryColor,
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
