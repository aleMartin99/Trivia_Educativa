import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
// import 'package:recarguita/core/widgets/buttons/gradient_button.dart';
// import 'package:recarguita/core/widgets/dedicated_app_bar/dedicated_app_bar.dart';
// import 'package:recarguita/core/widgets/dedicated_buttons/dedicated_button.dart';
// import 'package:recarguita/core/widgets/dedicated_refresh_scaffold/dedicated_refresh_scaffold.dart';
import 'package:trivia_educativa/main.dart';
// import 'package:recarguita/src/analytics/bloc/analytics_bloc.dart';
// import 'package:recarguita/src/onboarding/cubit/onboarding_cubit.dart';
// import 'package:trivia_educativa/src/onboarding/models/onboarding_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trivia_educativa/presentation/login/widgets/alert_dialog.dart';

import '../../../../core/app_routes.dart';
import '../../../../core/routers/routers.dart';
import '../../../../data/models/onboarding_item.dart';
import '../../../../data/models/user_model.dart';
import '../../../login/login_controller.dart';
import '../../../login/login_state.dart';
import '../../../shared/widgets/dedicated_app_bar.dart';
import '../../../shared/widgets/dedicated_button.dart';
import '../../../shared/widgets/dedicated_refresh_scaffold.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../cubit/onboarding_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const kOnboardingLightItems = [
  OnboardingItem('assets/onboarding/Frame 2.png',
      'Entérate de todas las promociones de Recarga'),
  OnboardingItem('assets/onboarding/Frame 2-1.png',
      'Recarga tu cuenta Cubacel o Nauta con los mejores planes'),
  OnboardingItem('assets/onboarding/Frame 2-2.png',
      'Envía saldo a tus familiares y amigos desde cualquier lugar'),
];
//TODO check dark mode for dark images
const kOnboardingDarkItems = [
  OnboardingItem('assets/onboarding/Frame 2.png',
      'Entérate de todas las promociones de Recarga'),
  OnboardingItem('assets/onboarding/Frame 2-1.png',
      'Recarga tu cuenta Cubacel o Nauta con los mejores planes'),
  OnboardingItem('assets/onboarding/Frame 2-2.png',
      'Envía saldo a tus familiares y amigos desde cualquier lugar'),
];

//TODO change text style and make I10n

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late final PageController _pageController;
  late double _currentPage;

  void _loadData() async {
    await controller.getUser();
  }

  @override
  void initState() {
    _loadData();
    controller.stateNotifier.addListener(() {
      // setState(() {});
      if (controller.state == LoginState.error) showAlertDialog(context);
    });
    super.initState();

    _currentPage = 0;
    _pageController = PageController()
      ..addListener(() => _currentPage = _pageController.page ?? 0);
  }

  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    List<OnboardingItem> items = Theme.of(context).brightness == Brightness.dark
        ? kOnboardingDarkItems
        : kOnboardingLightItems;
    return DedicatedScaffold(
      appBar: DedicatedAppBar(
          trailing: DedicatedTextButton(
        onPressed: () {
          context.read<OnboardingCubit>().markAsViewed();
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.homeRoute,
            // arguments: HomePageArgs(user: user),
          );
          // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
        style: Theme.of(context).textTheme.headline5?.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
            ),
        text: 'Saltar',
      )),
      bottomAppBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
          child: GradientButtonWidget(
            inactiveColor: Colors.grey,
            child: Text(
              'Continuar',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white,
                  ),
            ),
            isActive: true,
            onPressed: () async {
              if (_currentPage != kOnboardingDarkItems.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 1250),
                  curve: Curves.fastLinearToSlowEaseIn,
                );
              } else {
                context.read<OnboardingCubit>().markAsViewed();
                // sl<AnalyticsBloc>().add(const AnalyticsEvent.tutorialFinished());
                User user = controller.users!.last;
                log("${I10n.of(context).welcome}  ${user.nombreUsuario}.");

                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.homeRoute,
                  arguments: HomePageArgs(user: user),
                );
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/home', (route) => false);
              }
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
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
                        SizedBox(
                          height: _totalHeight / 10 * 6,
                          child: Image.asset(e.imagePath),
                        ),
                        SizedBox(
                          height: _totalHeight / 10 * 2,
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
                                    ?.copyWith(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _totalHeight / 10 * 2,
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
                controller: _pageController,
                count: items.length,
                axisDirection: Axis.horizontal,
                effect: SlideEffect(
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 16.0,
                  dotHeight: 4.0,
                  strokeWidth: 1.5,
                  dotColor: CupertinoColors.systemGrey,
                  activeDotColor: Theme.of(context).iconTheme.color!,
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
