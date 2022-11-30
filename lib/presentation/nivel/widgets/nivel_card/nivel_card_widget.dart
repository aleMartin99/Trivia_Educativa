import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/theme/text_theme.dart';

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
                minLeadingWidth: 33,
                contentPadding: const EdgeInsets.only(left: 8, right: 8),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (preguntas.length == 1)
                          ? "${preguntas.length} ${I10n.of(context).question}"
                          : "${preguntas.length} ${I10n.of(context).questions}",
                      style: AppTextStyles.regularText16.copyWith(
                        color: isDone
                            ? AppColors.black
                            : Theme.of(context).primaryIconTheme.color,
                      ),
                    ),
                    Text(
                      ' ● ',
                      style: AppTextStyles.regularText16.copyWith(
                        color: isDone
                            ? AppColors.black
                            : Theme.of(context).primaryIconTheme.color,
                      ),
                    ),
                    Text(
                      '$duracion min',
                      style: AppTextStyles.regularText16.copyWith(
                        color: isDone
                            ? AppColors.black
                            : Theme.of(context).primaryIconTheme.color,
                      ),
                    )
                  ],
                ),
                leading: isDone
                    ? const Icon(
                        Icons.check_box_rounded,
                        color: AppColors.chartPrimary,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color:
                            (Theme.of(context).brightness == Brightness.light)
                                ? AppColors.lightPurple
                                : Colors.grey[600],
                      ),
                horizontalTitleGap: 8,
                isThreeLine: true,
                dense: true,
                title: Text(
                  nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
