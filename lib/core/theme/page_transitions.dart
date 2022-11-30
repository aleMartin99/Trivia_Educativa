import 'package:flutter/material.dart';

const PageTransitionsTheme pageTransitions = PageTransitionsTheme(
  builders: {
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
  },
);
