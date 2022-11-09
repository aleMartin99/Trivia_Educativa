// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:quickalert/quickalert.dart';
// import 'package:trivia_educativa/core/app_colors.dart';
// import 'package:trivia_educativa/core/app_gradients.dart';
// import 'package:trivia_educativa/presentation/login/login_controller.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../core/app_routes.dart';
// import '../../core/dialogs.dart';
// import '../../core/routers/routers.dart';
// import '../../data/models/models.dart';
// import '../challenge/challenge_imports.dart';
// import 'login_state.dart';
// //TODO fix imports

// //TODO I10n
// //TODO check dark theme

// class CustomMenuModalPopupWidget extends StatefulWidget {
//   const CustomMenuModalPopupWidget({super.key});

//   @override
//   State<CustomMenuModalPopupWidget> createState() =>
//       _CustomMenuModalPopupWidgetState();
// }

// class _CustomMenuModalPopupWidgetState
//     extends State<CustomMenuModalPopupWidget> {
//   final TextEditingController usernameController = TextEditingController();

//   final TextEditingController passwordController = TextEditingController();
//   final LoginController _loginController = LoginController();

//   @override
//   void initState() {
//     Future.delayed(const Duration(microseconds: 1), () {
//       showPopup(isLogin: false);
//     });
//     _loginController.stateNotifier.addListener(() {
//       setState(() {});

//       if (_loginController.state == LoginState.loggedIn) {
//         QuickAlert.show(
//             context: context,
//             type: QuickAlertType.success,
//             title: 'Autenticacion Exitosa',
//             text: 'Bienvenido, ${_loginController.user!.name}',
//             onConfirmBtnTap: () async {
//               User? user = _loginController.user;
//               if (user != null) {
//                 await Navigator.of(context).pushReplacementNamed(
//                   AppRoutes.homeRoute,
//                   arguments: HomePageArgs(user: user),
//                 );
//               }
//             });
//       } else if (_loginController.state == LoginState.error) {
//         Dialoger.showErrorDialog(
//             context: context, title: 'CACAAAAA', description: 'esto se murio');
//       } else if (_loginController.state == LoginState.unauthorized) {
//         QuickAlert.show(
//             context: context,
//             type: QuickAlertType.error,
//             title: 'Credenciales Invalidas',
//             text: 'El usuario o la contrasenna esta mal');
//         _loginController.state = LoginState.empty;
//       } else if (_loginController.state == LoginState.notConnected) {
//         QuickAlert.show(
//             context: context,
//             type: QuickAlertType.warning,
//             title: 'No Internet Connection',
//             text:
//                 'Parece que no tienes conexión a internet. Por favor, revisa en los ajustes del teléfono');
//         _loginController.state = LoginState.empty;
//       }
//     });

//     super.initState();
//   }

//   showPopup({required bool isLogin}) {
//     showLoginForm() {
//       return Container(
//         height: 400,
//         width: 500,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           gradient: AppGradients.linear,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Login to continue",
//                   style: TextStyle(color: AppColors.white, fontSize: 30),
//                   // style: boldText(fSize: 30)
//                 ),
//                 // Text("This will ensure user data is saved to us",
//                 //     //   style: regulerText
//                 //     style: TextStyle(color: AppColors.white, fontSize: 20)),
//                 const SizedBox(height: 40),
//                 SizedBox(
//                   width: 400,
//                   height: 50,
//                   child: TextField(
//                       controller: usernameController,
//                       style: const TextStyle(color: AppColors.white),
//                       // style: regulerText,
//                       decoration: const InputDecoration(
//                         hintText: "Email address",
//                         //hintStyle:
//                         // regulerText
//                       )),
//                 ),
//                 SizedBox(
//                   width: 400,
//                   height: 50,
//                   child: TextField(
//                       controller: passwordController,
//                       style: const TextStyle(color: AppColors.white),
//                       //  style: regulerText,
//                       decoration: const InputDecoration(
//                         hintText: "Password",
//                         // hintStyle: regulerText
//                       )),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: TextButton(
//                           onPressed: () {
//                             QuickAlert.show(
//                                 context: context,
//                                 type: QuickAlertType.info,
//                                 title: 'Ha olvidado su contrasenna?',
//                                 text:
//                                     'Contacte con el administrador designado para que le restablezca la contrasenna');
//                           },
//                           child: const Text("Forget password?",
//                               style: TextStyle(color: AppColors.white)
//                               // regulerText
//                               )),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 50),
//                 ValueListenableBuilder<LoginState>(
//                   valueListenable: _loginController.stateNotifier,
//                   builder: (ctx, loadingValue, _) => Container(
//                     child: _loginController.state == LoginState.loading
//                         ? const Center(
//                             child: CircularProgressIndicator(
//                             color: Colors.green,
//                             backgroundColor: Colors.black12,
//                             //  valueColor: Colors.yellow,
//                           ))
//                         : Row(
//                             children: [
//                               Expanded(
//                                   child: NextButtonWidget.purple(
//                                       label: I10n.of(context).login,
//                                       onTap: () async {
//                                         log('First text field: ${usernameController.text}');
//                                         log('2nd text field: ${passwordController.text}');
//                                         await _loginController.signIn(
//                                             usernameController.text,
//                                             passwordController.text);

//                                         // User user = _loginController.user!;
//                                       }))
//                             ],
//                           ),

//                     // GestureDetector(
//                     //     onTap: () async {
//                     //       log('First text field: ${emailController.text}');
//                     //       log('2nd text field: ${passwordController.text}');
//                     //       await _loginController.signIn(
//                     //           emailController.text,
//                     //           passwordController.text);

//                     //       //  showPopup(isLogin: false);
//                     //     },
//                     //     child: Container(
//                     //         width: 150,
//                     //         height: 40,
//                     //         decoration: BoxDecoration(
//                     //             color: AppColors.purple,
//                     //             borderRadius: BorderRadius.circular(25)),
//                     //         child: const Center(
//                     //             child: Text(
//                     //           "Login", // style: boldText(fSize: 12)
//                     //           style: TextStyle(color: AppColors.white),
//                     //         ))),
//                     //   ),

//                     // ValueListenableBuilder<bool>(
//                     //     valueListenable: _loginController.loginNotifier,
//                     //     builder: (ctx, loginValue, _) => GestureDetector(
//                     //       onTap: () async {
//                     //         log('First text field: ${emailController.text}');
//                     //         log('2nd text field: ${passwordController.text}');
//                     //         await _loginController.signIn(
//                     //             emailController.text,
//                     //             passwordController.text);

//                     //         //  showPopup(isLogin: false);
//                     //       },
//                     //       child: Container(
//                     //           width: 150,
//                     //           height: 40,
//                     //           decoration: BoxDecoration(
//                     //               color: AppColors.purple,
//                     //               borderRadius: BorderRadius.circular(25)),
//                     //           child: const Center(
//                     //               child: Text(
//                     //             "Login", // style: boldText(fSize: 12)
//                     //             style: TextStyle(color: AppColors.white),
//                     //           ))),
//                     //     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//     showWelcomeBox() {
//       return Container(
//         height: 450,
//         width: 500,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           gradient: AppGradients.linear,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.close, color: Colors.white)),
//                 ],
//               ),
//               const Text(
//                 "Welcome!",
//                 style: TextStyle(color: AppColors.white),
//                 //  style: boldText(fSize: 40)
//               ),
//               const SizedBox(height: 30),
//               const Text(
//                 "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: AppColors.white),
//                 //  style: regulerText
//               ),
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: () {
//                   showPopup(isLogin: true);
//                 },
//                 child: Container(
//                     width: 300,
//                     height: 40,
//                     decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(8)),
//                     child: const Center(
//                         child: Text(
//                       "Login 🚀",
//                       style: TextStyle(color: AppColors.white),
//                       //   style: boldText(fSize: 12)
//                     ))),
//               ),
//             ],
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
//             content: isLogin ? showLoginForm() : showWelcomeBox(),
//           );
//         });
//   }

//   // @override
//   // void initState() {
//   //   Future.delayed(const Duration(microseconds: 1), () {
//   //     showPopup(isLogin: false);
//   //   });
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         //   backgroundColor: bgColor,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ActionChip(
//                   onPressed: () {
//                     showPopup(isLogin: true);
//                   },
//                   label: const Text(
//                     "Show Login Popup",
//                     style: TextStyle(color: AppColors.white),
//                     //  style: regulerText
//                   )),
//               ActionChip(
//                   onPressed: () {
//                     showPopup(isLogin: false);
//                   },
//                   label: const Text(
//                     "Show Welcome box Popup",
//                     style: TextStyle(color: AppColors.white),
//                     // style: regulerText
//                   )),
//               const SizedBox(height: 100),
//               // const AbhishvekHeaderWidget()
//             ],
//           ),
//         ));
//   }
// }
