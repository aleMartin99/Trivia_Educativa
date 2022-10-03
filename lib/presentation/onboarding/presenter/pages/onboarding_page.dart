import 'package:flutter/material.dart';
// import 'package:trivia_educativa/core/widgets/dedicated_app_bar/dedicated_app_bar.dart';
// import 'package:trivia_educativa/core/widgets/dedicated_refresh_scaffold/dedicated_refresh_scaffold.dart';
// import 'package:trivia_educativa/src/onboarding/models/onboarding_item.dart';

import '../../../../data/models/onboarding_item.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final PageController pageController;
  const OnboardingPage({
    Key? key,
    required this.item,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5 * 2,
                child: Image.asset(item.imagePath),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5 * 2,
                child: Center(
                  child: Text(
                    item.text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            item.footerBuilder != null ? item.footerBuilder!(context) : null);
  }
}
