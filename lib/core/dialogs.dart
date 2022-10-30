import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO ver tamannos letras y colores, no se actualiza el color del dialogo luego de cambiar el tema

class Dialoger {
  static Future<T?> showTwoChoicesDialog<T>({
    required BuildContext context,
    required String title,
    required String description,
    Color? backgroundColor,
    String? acceptText,
    Color? acceptColor,
    Color? declineColor,
    String? declineText,
  }) =>
      showTriviaDialog(
          context: context,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'PNBold',
              fontSize: 18,
            ),
          ),
          description: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'PNRegular',
              fontSize: 14,
              // fontWeight: FontWeight.w100,
            ),
          ),
          actions: [
            Action(name: declineText ?? 'Cancelar'),
            Action(name: acceptText ?? 'Aceptar', isDefault: true),
          ]);

  static Future<T?> showErrorDialog<T>({
    required BuildContext context,
    required String title,
    required String description,
    Color? backgroundColor,
    String buttonText = 'Ok',
    Color buttonTextColor = Colors.red,
  }) =>
      showTriviaDialog(
          context: context,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'PNBold',
              fontSize: 18,
            ),
          ),
          description: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'PNRegular',
              fontSize: 14,
              // fontWeight: FontWeight.w100,
            ),
          ),
          actions: [
            Action(
              name: 'OK',
            ),
          ]);

  static Future<T?> showTriviaDialog<T>({
    required BuildContext context,
    required Widget title,
    required Widget description,
    required List<Action<T>> actions,
    bool expandDescription = false,
    EdgeInsets padding = const EdgeInsets.all(16),
    Color? barrierColor,
    Duration? transitionDuration,
    Curve? transitionCurve,
    FutureOr<void> Function<T>(T action)? callbackAction,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return showCupertinoDialog<T?>(
        barrierDismissible: true,
        barrierLabel: 'Dismiss',
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: title,
          content: description,
          actions: actions
              .map(
                (e) => CupertinoDialogAction(
                  isDestructiveAction: e.isDestructive,
                  isDefaultAction: e.isDefault,
                  child: Text(
                    e.name,
                    style: TextStyle(
                      fontFamily: e.isDefault ? 'PNBold' : 'PNRegular',
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, e.name);
                    if (callbackAction != null) callbackAction(e);
                  },
                ),
              )
              .toList(),
        ),
      );
    }
    final actionsWidget = actions
        .map<Widget>(
          (action) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              focusColor: Theme.of(context).canvasColor,
              highlightColor: Theme.of(context).canvasColor,
              splashColor: Colors.transparent,
              onTap: () {
                if (callbackAction != null) callbackAction(action);
                Navigator.pop(context, action.name);
              },
              child: Padding(
                //TODO Change if you dont want this paddding
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    action.name,
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
    return showGeneralDialog<T?>(
        barrierDismissible: true,
        barrierLabel: 'Dismiss',
        barrierColor: barrierColor ?? Colors.black.withOpacity(0.8),
        transitionDuration:
            transitionDuration ?? const Duration(milliseconds: 300),
        context: context,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: transitionCurve ?? Curves.easeInOutBack,
            ),
            child: child,
          );
        },
        pageBuilder: (context, anim, anim2) {
          final _description = Padding(
            padding: const EdgeInsets.only(top: 8),
            child: description,
          );
          return Dialog(
            backgroundColor: Theme.of(context).canvasColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            // insetPadding: EdgeInsets.zero,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2,
                minHeight: 50,
              ),
              child: Padding(
                padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (expandDescription)
                      Expanded(
                        child: Column(
                          children: [title, Expanded(child: _description)],
                        ),
                      )
                    else
                      Column(
                        children: [
                          title,
                          _description,
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: actionsWidget.length > 1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // crossAxisAlignment: WrapCrossAlignment.center,
                              // alignment: WrapAlignment.spaceBetween,
                              children: actionsWidget
                                  .map((e) => Expanded(child: e))
                                  .toList(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: actionsWidget,
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  // static Future<String?> showCVVConfirmation({
  //   required BuildContext context,
  //   required CreditCardModel e,
  // }) {
  //   String? cvv;
  //   if (Theme.of(context).platform == TargetPlatform.iOS) {
  //     return showCupertinoDialog<String?>(
  //       barrierDismissible: true,
  //       barrierLabel: 'Dismiss',
  //       context: context,
  //       builder: (context) => CupertinoAlertDialog(
  //           title: Column(
  //             children: [
  //               const Text(
  //                 'Confirme CVV',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontFamily: 'PNBold',
  //                   fontSize: 18,
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   getCardTypeIcon(
  //                     context,
  //                     e.number,
  //                     ccType: e.cardType,
  //                   ),
  //                   Text(
  //                     '**** **** **** ${e.lastFour}',
  //                     style: Theme.of(context).textTheme.headline4?.copyWith(
  //                           fontSize: 14,
  //                         ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           content: Column(
  //             children: [
  //               CupertinoTextField(
  //                 decoration: BoxDecoration(
  //                   color: Colors.transparent,
  //                   border: Border.all(
  //                     color: Theme.of(context).dividerColor,
  //                   ),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(8),
  //                   ),
  //                 ),
  //                 placeholder: 'CVV',
  //                 textInputAction: TextInputAction.next,
  //                 style: Theme.of(context).textTheme.bodyText1?.copyWith(),
  //                 keyboardType: TextInputType.number,
  //                 maxLength: e.cardType == CardType.americanExpress ? 4 : 3,
  //                 onChanged: (value) {
  //                   cvv = value;
  //                 },
  //               ),
  //               const SizedBox(
  //                 height: 8,
  //               ),
  //               Text(
  //                 e.cardType == CardType.americanExpress
  //                     ? 'El CVV son los cuatro dígitos en el frontal de su tarjeta'
  //                     : 'El CVV son los tres dígitos en el reverso de tu tarjeta',
  //                 style: Theme.of(context).textTheme.caption,
  //               )
  //             ],
  //           ),
  //           actions: [
  //             CupertinoDialogAction(
  //               isDestructiveAction: false,
  //               isDefaultAction: false,
  //               child: Text(
  //                 'Cancelar',
  //                 style: TextStyle(
  //                     fontFamily: 'PNRegular',
  //                     color: Theme.of(context).primaryColor),
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             CupertinoDialogAction(
  //               isDestructiveAction: false,
  //               isDefaultAction: true,
  //               child: Text(
  //                 'Aceptar',
  //                 style: TextStyle(
  //                   fontFamily: 'PNBold',
  //                   color: Theme.of(context).primaryColor,
  //                 ),
  //               ),
  //               onPressed: () {
  //                 if (cvv != null) {
  //                   Navigator.pop(context, cvv);
  //                 } else {
  //                   showErrorDialog(
  //                     context: context,
  //                     title: 'CVV incorrecto',
  //                     description: 'Introduce correctamente tu CVV',
  //                   );
  //                 }
  //               },
  //             ),
  //           ]),
  //     );
  //   }

  //   return showGeneralDialog<String?>(
  //       barrierDismissible: true,
  //       barrierLabel: 'Dismiss',
  //       barrierColor: Colors.black.withOpacity(0.8),
  //       transitionDuration: const Duration(milliseconds: 300),
  //       context: context,
  //       transitionBuilder: (context, animation, secondaryAnimation, child) {
  //         return FadeTransition(
  //           opacity: CurvedAnimation(
  //             parent: animation,
  //             curve: Curves.easeInOutBack,
  //           ),
  //           child: child,
  //         );
  //       },
  //       pageBuilder: (context, anim, anim2) {
  //         final _description = Padding(
  //           padding: const EdgeInsets.only(top: 8),
  //           child: Column(
  //             children: [
  //               CupertinoTextField(
  //                 decoration: BoxDecoration(
  //                   color: Colors.transparent,
  //                   border: Border.all(
  //                     color: Theme.of(context).dividerColor,
  //                   ),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(8),
  //                   ),
  //                 ),
  //                 placeholder: 'CVV',
  //                 textInputAction: TextInputAction.next,
  //                 style: Theme.of(context).textTheme.bodyText1?.copyWith(),
  //                 keyboardType: TextInputType.number,
  //                 maxLength: e.cardType == CardType.americanExpress ? 4 : 3,
  //                 onChanged: (value) {
  //                   cvv = value;
  //                 },
  //               ),
  //               const SizedBox(
  //                 height: 8,
  //               ),
  //               Text(
  //                 e.cardType == CardType.americanExpress
  //                     ? 'El CVV son los cuatro dígitos en el frontal de su tarjeta'
  //                     : 'El CVV son los tres dígitos en el reverso de tu tarjeta',
  //                 style: Theme.of(context).textTheme.caption,
  //               )
  //             ],
  //           ),
  //         );
  //         return Dialog(
  //           backgroundColor: Theme.of(context).canvasColor,
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  //           child: Container(
  //             constraints: BoxConstraints(
  //               maxHeight: MediaQuery.of(context).size.height / 2,
  //               minHeight: 50,
  //             ),
  //             child: Padding(
  //               padding: EdgeInsets.all(16),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Column(
  //                     children: [
  //                       Column(
  //                         children: [
  //                           const Text(
  //                             'Confirme CVV',
  //                             style: TextStyle(
  //                               fontFamily: 'PNBold',
  //                               fontSize: 18,
  //                               // fontWeight: FontWeight.w100,
  //                             ),
  //                           ),
  //                           getCardTypeIcon(
  //                             context,
  //                             e.number,
  //                             ccType: e.cardType,
  //                           ),
  //                           Text(
  //                             '•••• •••• •••• ${e.lastFour}',
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .headline4
  //                                 ?.copyWith(
  //                                   fontSize: 14,
  //                                 ),
  //                           ),
  //                         ],
  //                       ),
  //                       _description,
  //                     ],
  //                   ),
  //                   Container(
  //                     padding: const EdgeInsets.only(top: 16),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       // crossAxisAlignment: WrapCrossAlignment.center,
  //                       // alignment: WrapAlignment.spaceBetween,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 16),
  //                           child: InkWell(
  //                             focusColor: Theme.of(context).canvasColor,
  //                             highlightColor: Theme.of(context).canvasColor,
  //                             // highlightColor: Colors.transparent,
  //                             splashColor: Colors.transparent,
  //                             onTap: () {
  //                               Navigator.pop(context);
  //                             },
  //                             child: Padding(
  //                               padding:
  //                                   const EdgeInsets.symmetric(vertical: 8),
  //                               child: Center(
  //                                 child: Text(
  //                                   'Cancelar',
  //                                   style: Theme.of(context)
  //                                       .textTheme
  //                                       .headline3
  //                                       ?.copyWith(
  //                                         fontSize: 16,
  //                                         color: Theme.of(context).primaryColor,
  //                                       ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 16),
  //                           child: InkWell(
  //                             focusColor: Theme.of(context).canvasColor,
  //                             highlightColor: Theme.of(context).canvasColor,
  //                             // highlightColor: Colors.transparent,
  //                             splashColor: Colors.transparent,
  //                             onTap: () {
  //                               if (cvv != null) {
  //                                 Navigator.pop(context, cvv);
  //                               } else {
  //                                 showErrorDialog(
  //                                   context: context,
  //                                   title: 'CVV incorrecto',
  //                                   description:
  //                                       'Introduce correctamente tu CVV',
  //                                 );
  //                               }
  //                             },
  //                             child: Padding(
  //                               padding:
  //                                   const EdgeInsets.symmetric(vertical: 8),
  //                               child: Center(
  //                                 child: Text(
  //                                   'Aceptar',
  //                                   style: Theme.of(context)
  //                                       .textTheme
  //                                       .headline3
  //                                       ?.copyWith(
  //                                         fontSize: 16,
  //                                         color: Theme.of(context).primaryColor,
  //                                       ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
}

class Action<T> {
  Action({
    required this.name,
    this.isDestructive = false,
    this.isDefault = false,
    this.color,
    this.backgroundColor,
  });

  final String name;
  final bool isDestructive;
  final bool isDefault;
  final Color? color;
  final Color? backgroundColor;
}
