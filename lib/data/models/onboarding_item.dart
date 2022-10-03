import 'package:flutter/material.dart';

class OnboardingItem {
  final String imagePath;
  final String text;
  final Widget Function(BuildContext context)? footerBuilder;
  final Widget Function(BuildContext context)? skipperBuilder;

  const OnboardingItem(
    this.imagePath,
    this.text, {
    this.footerBuilder,
    this.skipperBuilder,
  });
}
