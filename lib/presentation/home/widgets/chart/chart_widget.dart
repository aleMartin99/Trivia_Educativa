import 'package:flutter/material.dart';

import 'package:trivia_educativa/core/core.dart';

import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';

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
  final challengeController = ChallengeController();

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
    await challengeController.getNotasProv();
  }

  @override
  void initState() {
    _loadData();
    _initAnimation();
    challengeController.stateNotifier.addListener(() {
      if (challengeController.state == ChallengeState.notasLoaded) {
        setState(() {});
        _controller.reset();
        _initAnimation();
      }
    });
    super.initState();
  }

  double getScorePercentage() {
    double scorePercentage;
    if (challengeController.notasProv != null &&
        challengeController.notasProv!.isNotEmpty) {
      scorePercentage = (cantAprobados(challengeController.notasProv) /
              challengeController.notasProv!.length)
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
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.chartPrimary),
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
