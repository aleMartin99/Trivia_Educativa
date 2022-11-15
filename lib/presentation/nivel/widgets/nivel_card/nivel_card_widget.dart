import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/models.dart';

class NivelCardWidget extends StatelessWidget {
  //bool isDone = false;
  final String nombre;
  // late String subtitle;
  final List<Pregunta> preguntas;
  final bool isDone;
  final VoidCallback onTap;

  const NivelCardWidget({
    Key? key,
    required this.isDone,
    required this.nombre,
    required this.onTap,
    required this.preguntas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDone ? () {} : onTap,
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(bottom: 20),
        //color: Colors.amber,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // border: const Border.fromBorderSide(
          //   BorderSide(
          //     color: AppColors.border,
          //   ),
          // ),
          color: isDone
              ? (Theme.of(context).brightness == Brightness.light)
                  ? Colors.black12
                  : AppColors.lightGrey
              : AppTheme.backgroundColors(Theme.of(context).brightness),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nombre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 21,
                        color: isDone
                            ? AppColors.black
                            : Theme.of(context).primaryIconTheme.color,
                        //color: settingsController.currentAppTheme.primaryColor,
                      ),
                ),
                isDone
                    ? const Icon(
                        Icons.check_box,
                        color: AppColors.chartPrimary,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color:
                            (Theme.of(context).brightness == Brightness.light)
                                ? AppColors.lightPurple
                                : Colors.grey[600],
                      )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  //Todo I10n
                  child: Text(
                    "Cant. de preguntas: ${preguntas.length}",
                    style: TextStyle(
                      fontFamily: 'PNRegular',
                      fontSize: 14,
                      color: isDone
                          ? AppColors.black
                          : Theme.of(context).primaryIconTheme.color,
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
