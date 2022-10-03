import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DedicatedIconButton extends StatelessWidget {
  const DedicatedIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.iconSize,
    this.opacityIOS = 0.4,
    this.splashRadius,
    this.padding,
  }) : super(key: key);

  final void Function()? onPressed;

  final Widget icon;
  final double? iconSize;
  final double opacityIOS;
  final double? splashRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final _iconSize = iconSize ?? 20;
    return Theme.of(context).platform == TargetPlatform.android
        ? IconButton(
            constraints: BoxConstraints(
              maxHeight: _iconSize * 2,
              minHeight: _iconSize * 2,
            ),
            iconSize: _iconSize,
            splashRadius: splashRadius ?? _iconSize,
            onPressed: onPressed,
            splashColor: Colors.transparent,
            icon: icon,
            padding: padding ?? EdgeInsets.all((iconSize ?? 24) / 3),
          )
        : CupertinoButton(
            pressedOpacity: opacityIOS,
            minSize: iconSize ?? 16,
            padding: padding ?? EdgeInsets.all((iconSize ?? 24) / 3),
            onPressed: onPressed,
            child: icon,
          );
  }
}

class DedicatedTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final TextStyle? style;
  final EdgeInsets? padding;
  const DedicatedTextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.style,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoButton(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 8),
        pressedOpacity: 0.8,
        onPressed: onPressed,
        child: Text(
          text,
          style: style ?? Theme.of(context).textTheme.headline5,
        ),
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor.withOpacity(0.1)),
          // elevation: MaterialStateProperty.all(3),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          text,
          style: style ?? Theme.of(context).textTheme.headline5,
        ),
      );
    }
  }
}

class DedicatedButton extends StatelessWidget {
  const DedicatedButton({
    Key? key,
    this.showSplash = false,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget child;
  final bool showSplash;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        pressedOpacity: 0.8,
        onPressed: onPressed,
        child: child,
      );
    } else {
      if (showSplash) {
        return InkWell(
          highlightColor: Theme.of(context).canvasColor,
          splashColor: Colors.transparent,
          onTap: onPressed,
          child: child,
        );
      } else {
        return InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: onPressed,
          child: child,
        );
      }
    }
  }
}
