import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/core.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import '../../../../core/theme/text_theme.dart';
import '../../../login/login_imports.dart';
import '../../../shared/shared_imports.dart';
import '../../onboarding_imports.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = LoginController();
  final onBoardingController = OnBoardingController();
  final pageController = PageController();

  void nextPage() {
    //* 3 is the length of the onBoarding items
    if (onBoardingController.currentPage < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
      );
    }
  }

  @override
  void initState() {
    pageController.addListener(
      () {
        onBoardingController.currentPage = pageController.page!.toInt() + 1;
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kOnboardingLightItems = [
      OnboardingItem(AppImages.onBoarding_1, I10n.of(context).onBoarding_1),
      OnboardingItem(AppImages.onBoarding_2, I10n.of(context).onBoarding_2),
      OnboardingItem(AppImages.onBoarding_3, I10n.of(context).onBoarding_3),
    ];
    final kOnboardingDarkItems = [
      OnboardingItem(AppImages.onBoarding_1, I10n.of(context).onBoarding_1),
      OnboardingItem(AppImages.onBoarding_2, I10n.of(context).onBoarding_2),
      OnboardingItem(AppImages.onBoarding_3, I10n.of(context).onBoarding_3),
    ];
    List<OnboardingItem> items = Theme.of(context).brightness == Brightness.dark
        ? kOnboardingDarkItems
        : kOnboardingLightItems;

    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return WillPopScope(
      onWillPop: () async => false,
      child: DedicatedScaffold(
        appBar: DedicatedAppBar(
            trailing: TextButton(
          onPressed: () {
            context.read<OnboardingCubit>().markAsViewed();
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.loginRoute,
            );
          },
          child: Text(
            I10n.of(context).skip,
            style: AppTextStyles.regularText16.copyWith(
              color: Theme.of(context).primaryIconTheme.color,
              decorationThickness: 1.5,
              decoration: TextDecoration.underline,
            ),
          ),
        )),
        bottomAppBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
            child: ValueListenableBuilder(
              valueListenable: onBoardingController.currentPageNotifier,
              builder: (context, int value, _) => Padding(
                padding: EdgeInsets.only(
                    bottom: 8.0, left: width * 5, right: width * 5),
                child: (NextButtonWidget.purple(
                  //inactiveColor: Colors.grey,

                  label: value == kOnboardingLightItems.length
                      ? I10n.of(context).continueText
                      : I10n.of(context).next,
                  onTap: () {
                    if (value != kOnboardingLightItems.length) {
                      nextPage();
                    } else {
                      context.read<OnboardingCubit>().markAsViewed();

                      Navigator.of(context).pushReplacementNamed(
                        AppRoutes.loginRoute,
                      );
                    }
                  },
                )),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            PageView(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              children: [
                ...items.map(
                  (e) => SafeArea(
                    bottom: false,
                    child: Builder(builder: (context) {
                      final _totalHeight = MediaQuery.of(context).size.height -
                          (2 * kToolbarHeight);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0, left: 40, right: 40, bottom: 20),
                            child: SizedBox(
                              height: _totalHeight / 10 * 5.5,
                              child: Stack(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      gradient: AppGradients.linear,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    e.imagePath,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _totalHeight / 10 * 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Center(
                                child: Text(
                                  e.text,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(
                                          fontSize: 21,
                                          color: Theme.of(context)
                                              .primaryIconTheme
                                              .color),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                        ],
                      );
                    }),
                  ),
                )
              ],
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height / 5 * 3,
              child: IgnorePointer(
                child: Center(
                    child: SmoothPageIndicator(
                  controller: pageController,
                  count: items.length,
                  axisDirection: Axis.horizontal,
                  effect: SlideEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 16.0,
                    dotHeight: 4.0,
                    strokeWidth: 1.5,
                    dotColor: CupertinoColors.systemGrey,
                    activeDotColor: Theme.of(context).primaryIconTheme.color!,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
