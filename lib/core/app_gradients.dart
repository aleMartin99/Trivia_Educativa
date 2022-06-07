import 'dart:math';

import 'package:flutter/material.dart';

class AppGradients {
  static const linear = LinearGradient(colors: [
    Color(0xFF57B6E0),
    Color.fromARGB(153, 81, 6, 255),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));
}
