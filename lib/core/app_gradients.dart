import 'dart:math';

import 'package:flutter/material.dart';

class AppGradients {
  static const linear = LinearGradient(colors: [
    Color.fromARGB(153, 81, 6, 255),
    Color(0xFF57B6E0),
  ], stops: [
    0.0,
    1.0
  ], transform: GradientRotation(2.13959913 * pi));
}
