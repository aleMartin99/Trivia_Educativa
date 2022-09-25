import 'package:trivia_educativa/core/app_text_styles.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class MyAlert extends StatelessWidget {
//   const MyAlert({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: TextButton(
//         child: const Text('Show alert'),
//         onPressed: () {
//           showAlertDialog(context);
//         },
//       ),
//     );
//   }
// }

showAlertDialog(BuildContext context) {
  SettingsController settingsController =
      Provider.of<SettingsController>(context, listen: false);
  // Create button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: AppTextStyles.heading
          .copyWith(color: settingsController.currentAppTheme.primaryColor),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      children: [
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text(
          " ${I10n.of(context).error}!!",
          style: AppTextStyles.heading.copyWith(
            color: settingsController.currentAppTheme.primaryColor,
          ),
        ),
      ],
    ),
    content: Text(
      "${I10n.of(context).problem_data}: \n${I10n.of(context).checkConnection}",
      style: AppTextStyles.body.copyWith(
        color: settingsController.currentAppTheme.primaryColor,
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
