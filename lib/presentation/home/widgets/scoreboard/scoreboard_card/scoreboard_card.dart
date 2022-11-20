import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class ScoreBoardCard extends StatelessWidget {
  const ScoreBoardCard(
      {Key? key,
      required this.name,
      required this.promedio,
      required this.isUser})
      : super(key: key);
  final String name;
  final double promedio;
  final bool isUser;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return Container(
      height: height * 10,
      margin: const EdgeInsets.only(bottom: 20),
      //color: Colors.amber,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: AppTheme.backgroundColors(Theme.of(context).brightness),
        //TODO validar si es el usuario
        color: isUser
            ? AppColors.purple
            : AppTheme.backgroundColors(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.85,
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 21,
                        //color: Theme.of(context).primaryIconTheme.color,
                        //TODO Validar Si es el usuario
                        color: isUser
                            ? AppColors.white
                            : Theme.of(context).primaryIconTheme.color,
                      ),
                ),
              ),
            ),
            Text(
              promedio.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 21,
                    // color: Theme.of(context).primaryIconTheme.color,
                    //TODO Validar Si es el usuario
                    color: isUser
                        ? AppColors.white
                        : Theme.of(context).primaryIconTheme.color,
                  ),
            ),
            const Icon(
              Icons.star_rounded,
              color: Colors.orangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}
