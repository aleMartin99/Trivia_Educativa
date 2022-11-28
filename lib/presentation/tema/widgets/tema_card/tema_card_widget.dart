import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(2),
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
                  "${I10n.of(context).levels}: $cantNiveles",
                  style: TextStyle(
                    //TODO check textStyle
                    fontFamily: 'PNRegular',
                    fontSize: 16,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
