import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';

//import 'package:dev_quiz/core/app_colors.dart';
import 'package:trivia_educativa/core/core.dart';
import 'package:provider/provider.dart';

//TODO make reactive to api callback for rebuilding the chart
class ChartWidget extends StatefulWidget {
  ChartWidget({
    Key? key,
    required percent,
  }) : super(
          key: key,
        ) {
    percentNotifier = ValueNotifier<double>(percent);
  }

  // var percent =
  // ValueNotifier<double>(1);

  late ValueNotifier<double> percentNotifier; // notificador de pagina atual
  double get percent => percentNotifier.value;
  set percent(double value) => percentNotifier.value = value;

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percent,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

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
                //*saca la info de percent
                child: ValueListenableBuilder(
                  valueListenable: widget.percentNotifier,
                  builder: (ctx, value, _) => CircularProgressIndicator(
                    strokeWidth: 10,
                    value: _animation.value,
                    backgroundColor: AppColors.chartSecondary,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.chartPrimary),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "${(_animation.value * 100).toStringAsFixed(0)}%",
                style: AppTextStyles.heading.copyWith(
                  color: settingsController.currentAppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
