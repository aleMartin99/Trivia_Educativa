import 'package:trivia_educativa/core/app_text_styles.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          " Error!!",
          style: AppTextStyles.heading.copyWith(
            color: settingsController.currentAppTheme.primaryColor,
          ),
        ),
      ],
    ),
    content: Text(
      "Ocurrió un problema accediendo a los datos: \nRevise su conexión",
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
