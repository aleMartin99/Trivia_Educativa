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
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return GestureDetector(
      onTap: isDone ? () {} : onTap,
      child: Container(
        height: height * 11,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(2),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                subtitle: Text(
                  "Cant. de preguntas: ${preguntas.length}",
                  style: TextStyle(
                    fontFamily: 'PNRegular',
                    fontSize: 16,
                    color: isDone
                        ? AppColors.black
                        : Theme.of(context).primaryIconTheme.color,
                    // fontWeight: FontWeight.w100,
                  ),
                ),
                trailing: isDone
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
                title: Text(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
