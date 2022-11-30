import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

class GradientAppBarWidget extends StatelessWidget {
  final Widget child;
  const GradientAppBarWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return Container(
      height: height * 20,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: width * 5,
      ),
      decoration: const BoxDecoration(
        gradient: AppGradients.linear,
      ),
      child: child,
    );
  }
}
