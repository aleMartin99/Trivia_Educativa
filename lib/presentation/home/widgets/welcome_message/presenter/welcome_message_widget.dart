
//  import 'dart:js';

// import 'package:flutter/material.dart';

// import '../../../../../core/core.dart';


// context.read<OnboardingCubit>().markAsViewed();
//   showWelcomeBox() {
//     showWelcomeBox() {
//       return Container(
//         alignment: Alignment.topLeft,
//         height: 440,
//         width: 500,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           gradient: AppGradients.linear,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Text(
//                         "Bienvenido!",
//                         style: TextStyle(color: AppColors.white, fontSize: 24),
//                         //  style: boldText(fSize: 40)
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 2.0),
//                   child: Text(
//                     "Esta aplicación está destinada al apoyo del proceso educativo como alternativa a los métodos convencionales.\n\nAsí, los profesores podrán medir sus conocimientos y conocer su dominio acerca de ciertos temas y diferentes asignaturas.\n\nDiviértete y aprende!",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(color: AppColors.white, fontSize: 18),
//                     //  style: regulerText
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 GestureDetector(
//                   onTap: () async {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                       width: 400,
//                       height: 48,
//                       decoration: BoxDecoration(
//                           color: AppColors.purple,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: const Center(
//                           child: Text(
//                         'OK', // style: boldText(fSize: 12)
//                         style: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ))),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//             contentPadding: EdgeInsets.zero,
//             content: showWelcomeBox(),
//           );
//         });
//   }