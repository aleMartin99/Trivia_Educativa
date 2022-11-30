import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trivia_educativa/data/models/asignatura_model.dart';

import '../../../../core/app_icons.dart';
import '../../../../core/theme/text_theme.dart';

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
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 500,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.symmetric(
          horizontal: width * 3.8,
          vertical: height * 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.backgroundColors(Theme.of(context).brightness),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.50),
              child: Center(
                child: SizedBox(
                    height: height * 10,
                    //color: Colors.red,
                    child: CustomIconSVG(
                      iconName: asignatura.icon,
                    )),
              ),
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                Text(asignatura.descripcion,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regularText16.copyWith(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            Text(
                (asignatura.temas.length == 1)
                    ? "${asignatura.temas.length} ${I10n.of(context).topic}"
                    : "${asignatura.temas.length} ${I10n.of(context).topics}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.regularText16.copyWith(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
