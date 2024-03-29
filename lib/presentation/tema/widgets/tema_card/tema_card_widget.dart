import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/theme/text_theme.dart';

class TemaCardWidget extends StatelessWidget {
  final String nombre;
  final int cantNiveles;

  final VoidCallback onTap;

  const TemaCardWidget({
    Key? key,
    required this.nombre,
    required this.cantNiveles,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 11,
        margin: EdgeInsets.only(bottom: height * 2),
        padding: EdgeInsets.symmetric(
          horizontal: 0.475,
          vertical: height * 0.25,
        ),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColors(Theme.of(context).brightness),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  nombre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 21,
                      color: Theme.of(context).primaryIconTheme.color),
                ),
                subtitle: Text(
                  (cantNiveles == 1)
                      ? "$cantNiveles ${I10n.of(context).level}"
                      : "$cantNiveles ${I10n.of(context).levels}",
                  style: AppTextStyles.regularText16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
