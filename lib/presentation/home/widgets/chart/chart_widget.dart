import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

import 'package:trivia_educativa/data/models/models.dart';

import '../../../../data/models/auth_model.dart';
import '../../../../main.dart';
import '../../home_imports.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    Key? key,
    // required this.percent,
  }) : super(
          key: key,
        );

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final homeController = HomeController();
  var auth = sl<Auth>();

  ///TOdo check error de q se accede sin datos
  //var notas = sl<List<NotaProv>>();
  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: getScorePercentage(),
    ).animate(_controller);

    _controller.forward();
  }

//TODO TESTEAr chart widget varias notas no hace nada se qeda en 0
  static int cantAprobados(List<NotaProv>? notasProv) {
    int cantAprobados = 0;
    for (int i = 0; i < notasProv!.length; i++) {
      if (notasProv[i].nota > 2) cantAprobados++;
    }
    return cantAprobados;
  }

  // void _loadData() async {
  //   await homeController.getNotasProv(user.ci);
  // }

  // sl.pushNewScope();
  //   User user = _loginController.user;
  //   sl.registerSingleton<User>(user);

  void _loadData() async {
    await homeController.getNotasProv(auth.user.ci, auth.token);
  }

  @override
  void initState() {
    _loadData();
    //sl.pushNewScope();
    // List<NotaProv> noticas = homeController.notas!;
    // sl.registerSingleton<List<NotaProv>>(noticas);
    _initAnimation();
    homeController.stateNotifier.addListener(() {
      if (homeController.state == HomeState.notasLoaded) {
        setState(() {});
        _controller.reset();
        _initAnimation();
      }
    });

    super.initState();
  }

  double getScorePercentage() {
    double scorePercentage;

    //double scorePercentage = 0.6;

    if (homeController.notas != null && homeController.notas!.isNotEmpty) {
      scorePercentage =
          (cantAprobados(homeController.notas) / homeController.notas!.length)
              .toDouble();
    } else {
      scorePercentage = 0;
    }

    return scorePercentage;
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  //var notas = sl<List<NotaProv>>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) => Stack(
          children: [
            Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: _animation.value,
                  backgroundColor: AppColors.purpleLight,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
                ),
              ),
            ),
            Center(
              child: Text(
                "${(_animation.value * 100).toStringAsFixed(0)}%",
                style: AppTextStyles.heading.copyWith(
                  color: Theme.of(context).primaryIconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
