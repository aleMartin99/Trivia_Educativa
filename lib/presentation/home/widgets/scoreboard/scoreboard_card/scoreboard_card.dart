import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class ScoreBoardCard extends StatelessWidget {
  const ScoreBoardCard({Key? key, required this.name, required this.promedio})
      : super(key: key);
  final String name;
  final int promedio;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 20),
      //color: Colors.amber,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColors(Theme.of(context).brightness),
        //TODO validar si es el usuario
        // color: isDone
        //     ? (Theme.of(context).brightness == Brightness.light)
        //         ? Colors.black12
        //         : AppColors.lightGrey
        //     : AppTheme.backgroundColors(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 21,
                    color: Theme.of(context).primaryIconTheme.color,
                    //TODO Validar Si es el usuario
                    // color: isDone
                    //     ? AppColors.black
                    //     : Theme.of(context).primaryIconTheme.color,
                  ),
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
                    "Promedio: $promedio",
                    style: TextStyle(
                      fontFamily: 'PNRegular',
                      fontSize: 14,
                      //TODO validar si es el usuario
                      // color: isDone
                      //     ? AppColors.black
                      //     : Theme.of(context).primaryIconTheme.color,
                      color: Theme.of(context).primaryIconTheme.color,
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
