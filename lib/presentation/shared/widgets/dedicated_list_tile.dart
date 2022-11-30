import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DedicatedListTile extends StatelessWidget {
  final FutureOr<void> Function()? onLongPressed;
  final FutureOr<void> Function()? onPressed;
  final Color? color;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool? enabled;
  final double size;

  const DedicatedListTile(
      {Key? key,
      this.onLongPressed,
      this.onPressed,
      this.color,
      this.title,
      this.subtitle,
      this.trailing,
      this.leading,
      this.enabled,
      this.size = 36})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    if (Platform.isIOS) {
      return GestureDetector(
        onLongPress: onLongPressed,
        child: CupertinoButton(
          pressedOpacity: 0.6,
          padding: EdgeInsets.zero,
          child: ListTile(
            trailing: trailing,
            leading: SizedBox(
              width: size,
              height: size,
              child: Center(
                child: leading,
              ),
            ),
            title: title,
            subtitle: subtitle,
            enabled: enabled ?? true,
          ),
          onPressed: onPressed,
        ),
      );
    } else {
      return ListTile(
        onLongPress: onLongPressed,
        onTap: onPressed,
        trailing: trailing,
        leading: SizedBox(
          width: width * 8.55,
          height: height * 4,
          child: Center(
            child: leading,
          ),
        ),
        title: title,
        subtitle: subtitle,
        enabled: enabled ?? true,
      );
    }
  }
}
