import 'package:trivia_educativa/core/app_theme.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/pregunta_model.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NivelCardWidget extends StatelessWidget {
  //bool isDone = false;
  late String nombre;
  // late String subtitle;
  late List<Pregunta> preguntas;
  late bool isDone;
  final VoidCallback onTap;

  NivelCardWidget({
    Key? key,
    required this.isDone,
    required this.nombre,
    required this.onTap,
    required this.preguntas,
  }) : super(key: key);

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
          color: isDone
              ? Colors.black12
              : AppTheme.backgroundColors(
                  settingsController.currentAppTheme.brightness),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //*Icono para la info del modo de juego
            // SizedBox(
            //   width: 40,
            //   height: 40,
            //   child: Image.asset(
            //     AppImages.blocks,
            //   ),
            // ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Text(
                nombre,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.heading15.copyWith(
                  color: settingsController.currentAppTheme.primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            isDone
                ? const Icon(
                    Icons.check_circle,
                    color: AppColors.chartPrimary,
                  )
                : const Text(''),
          ],
        ),
      ),
    );
  }
}
