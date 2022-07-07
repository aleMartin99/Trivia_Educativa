import 'package:educational_quiz_app/core/app_theme.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/data/models/pregunta_model.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NivelCardWidget extends StatelessWidget {
  bool isDone = false;
  late String nombre;
  // late String subtitle;
  late List<Pregunta> preguntas;

  final VoidCallback onTap;

  NivelCardWidget({
    Key? key,
    required this.nombre,
    required this.onTap,
    required this.preguntas,
  }) : super(key: key);
  //todo VER coMPLETADO JALARLO DINAMICO

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return GestureDetector(
      onTap: isDone ? () {} : onTap,
      child: Container(
        //color: Colors.amber,
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
                    Expanded(
                      child: Text(
                        nombre,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading15.copyWith(
                          color:
                              settingsController.currentAppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 15,
            ),
            isDone
                ? Text('Completado', style: AppTextStyles.bodyDarkGreen)
                : Text('Pendiente', style: AppTextStyles.bodyLightYellow),

            // Expanded(
            //   flex: 1,
            //   child:isDone
            //         ?  Text(
            //     "$completed de ${preguntas.length}",
            //     style: AppTextStyles.body11.copyWith(
            //       color: settingsController.currentAppTheme.primaryColor,
            //     ),
            //   ):Text(
            //     "$completed de ${preguntas.length}",
            //     style: AppTextStyles.body11.copyWith(
            //       color: settingsController.currentAppTheme.primaryColor,
            //     ),
            //   )
            // ),
            // Expanded(
            //   flex: 2,
            //   child: ProgressIndicatorWidget(
            //     value: isDone
            //         ? preguntas.length / preguntas.length
            //         : completed / preguntas.length,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
