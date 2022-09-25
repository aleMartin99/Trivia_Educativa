import 'package:trivia_educativa/core/app_text_styles.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//todo VERIFICAR DIALOGO
// showAlertDialog(BuildContext context) {
//   SettingsController settingsController =
//       Provider.of<SettingsController>(context);
//   // Create button
//   Widget cancelButton = TextButton(
//     child: const Text("Cancelar"),
//     onPressed: () {
//       Navigator.of(context).pop();
//     },
//   );
//   Widget okButton = TextButton(
//     child: const Text("OK"),
//     onPressed: () {
//        int nota = evaluarNivel(controller.puntos, widget.rango3,
//                         widget.rango4, widget.rango5);
//                     log(nota.toString());
//                     homeController.crearNota(nota);
//                     await homeController.getNotasProv();

//                     //*se asigna la nota
//                     //PutAsignar

//                     await homeController.asignarNota(
//                         widget.idAsignatura,
//                         widget.idCurso,
//                         widget.idTema,
//                         widget.idNivel,
//                         homeController.notasProv!.last.id);

//                     Navigator.pushReplacementNamed(
//                       context,
//                       AppRoutes.resultRoute,
//                       arguments: ResultPageArgs(
//                           quizTitle: widget.quizTitle,
//                           questionsLenght: widget.preguntas.length,
//                           result: controller.qtdRightAnswers,
//                           rango3: widget.rango3,
//                           rango4: widget.rango4,
//                           rango5: widget.rango5,
//                           puntos: controller.puntos,
//                           idAsignatura: widget.idAsignatura,
//                           idCurso: widget.idCurso,
//                           idTema: widget.idTema,
//                           idNivel: widget.idNivel),
//                     );
//     },
//   );

//   // Create AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Row(
//       children: [
//         const Icon(
//           Icons.error,
//           color: Colors.red,
//         ),
//         Text(
//           "Esta seguro que desea salir?",
//           style: AppTextStyles.heading.copyWith(
//             color: settingsController.currentAppTheme.primaryColor,
//           ),
//         ),
//       ],
//     ),
//     content: Text(
//       "Si deja el nivel ahora se le evaluara tomando en cuenta solamente las preguntas realizadas",
//       style: AppTextStyles.body.copyWith(
//         color: settingsController.currentAppTheme.primaryColor,
//       ),
//     ),
//     actions: [
//       okButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }