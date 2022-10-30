import '../../../../core/app_theme.dart';
import '../../../../data/models/nota_prov_model.dart';
import '../../../challenge/challenge_controller.dart';
import '../../../challenge/challenge_state.dart';
import 'package:flutter/material.dart';
import 'package:trivia_educativa/core/core.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    Key? key,
    // required this.percent,
  }) : super(
          key: key,
        );

  // final double percent ;
//TODO se parte cuando pongo dark mode y cierro sesion, error de los ticker provider
  // var percent =
  // ValueNotifier<double>(1);

  // notificador de pagina atual
  /// final percentNotifier;

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
    // log((cantAprobados / notasProv.length).toDouble().toString());
    return cantAprobados;
  }

  void _loadData() async {
    await challengeController.getNotasProv();
    //log(challengeController.notasProv!.last.nota.toString());
  }

  @override
  void initState() {
    _loadData();
    _initAnimation();
    //_initAnimation();
    // Future.delayed(const Duration(seconds: 3));
    //_initAnimation();
    //_controller.dispose();
    challengeController.stateNotifier.addListener(() {
      if (challengeController.state == ChallengeState.notasLoaded) {
        setState(() {});
        _controller.reset();
        _initAnimation();
        //_controller.clearListeners();
        //   _controller.dispose();

        // Future.delayed(const Duration(seconds: 1));
        // _initAnimation();
        // Dialoger.showErrorDialog(
        //   context: context,
        //   title: 'ChallengeState Listenter',
        //   description: 'ChallengeState.notasLoaded',
        // );
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

  //double scorePercentage =

//TODO CHeck when loging out se parte
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
    //_animation.dispose(); // you need this
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: AnimatedBuilder(
        //? here is the problem with the late variable not initialized
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
