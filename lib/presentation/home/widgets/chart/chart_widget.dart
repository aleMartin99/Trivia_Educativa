import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

import 'package:trivia_educativa/data/models/models.dart';

import '../../../../core/theme/text_theme.dart';
import '../../../../data/models/auth_model.dart';
import '../../../../main.dart';
import '../../home_imports.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    Key? key,
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

  static int cantAprobados(List<NotaProv>? notasProv) {
    int cantAprobados = 0;
    for (int i = 0; i < notasProv!.length; i++) {
      if (notasProv[i].nota > 2) cantAprobados++;
    }
    return cantAprobados;
  }

  void _loadData() async {
    await homeController.getNotasProv(auth.user.ci, auth.token);
  }

  @override
  void initState() {
    _loadData();
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return SizedBox(
      height: height * 10,
      width: width * 20,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) => Stack(
          children: [
            Center(
              child: SizedBox(
                height: height * 10,
                width: width * 20,
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
