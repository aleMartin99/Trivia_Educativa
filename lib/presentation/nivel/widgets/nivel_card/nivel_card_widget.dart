import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NivelCardWidget extends StatelessWidget {
  final String nombre;
  final List<Pregunta> preguntas;
  final bool isDone;
  final VoidCallback onTap;
  final int duracion;

  const NivelCardWidget({
    Key? key,
    required this.isDone,
    required this.duracion,
    required this.nombre,
    required this.onTap,
    required this.preguntas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return GestureDetector(
      onTap: isDone ? () {} : onTap,
      child: Container(
        height: height * 11,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isDone
              ? (Theme.of(context).brightness == Brightness.light)
                  ? Colors.black12
                  : AppColors.lightGrey
              : AppTheme.backgroundColors(Theme.of(context).brightness),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                subtitle: Text(
                  " ${I10n.of(context).numberOfQuestions}${preguntas.length}",
                  //TODO check textSTyle
                  style: TextStyle(
                    fontFamily: 'PNRegular',
                    fontSize: 16,
                    color: isDone
                        ? AppColors.black
                        : Theme.of(context).primaryIconTheme.color,
                  ),
                ),
                leading: isDone
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.chartPrimary,
                      )
                    : Icon(
                        Icons.circle_outlined,
                        color:
                            (Theme.of(context).brightness == Brightness.light)
                                ? AppColors.lightPurple
                                : Colors.grey[600],
                      ),
                horizontalTitleGap: 10,
                isThreeLine: true,
                dense: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer,
                      size: 20,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    Text(
                      '$duracion min',
                      //TODO check textSTyle
                      style: TextStyle(
                        fontFamily: 'PNRegular',
                        fontSize: 14,
                        color: isDone
                            ? AppColors.black
                            : Theme.of(context).primaryIconTheme.color,
                      ),
                    )
                  ],
                ),
                title: Text(
                  nombre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  //TODO check textSTyle
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 21,
                        color: isDone
                            ? AppColors.black
                            : Theme.of(context).primaryIconTheme.color,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
