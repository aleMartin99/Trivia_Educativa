import 'package:trivia_educativa/data/models/answer_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/core.dart';
import '../../../settings/settings_controller.dart';

class AnswerWidget extends StatefulWidget {
  final AnswerModel answerModel;
  final bool isSelected;
  final bool isDisabled;
  final ValueChanged<bool> onTap;

  const AnswerWidget({
    Key? key,
    required this.answerModel,
    required this.onTap,
    this.isSelected = false,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  Color get _selectedColorRight =>
      widget.answerModel.isRight ? AppColors.darkGreen : AppColors.darkRed;

  Color get _selectedBorderRight =>
      widget.answerModel.isRight ? AppColors.lightGreen : AppColors.lightRed;

  Color get _selectedColorCardRight =>
      widget.answerModel.isRight ? AppColors.lightGreen : AppColors.lightRed;

  Color get _selectedBorderCardRight =>
      widget.answerModel.isRight ? AppColors.green : AppColors.red;

  TextStyle get _selectedTextStyleRight => widget.answerModel.isRight
      ? AppTextStyles.bodyDarkGreen
      : AppTextStyles.bodyDarkRed;

  IconData get _selectedIconRight =>
      widget.answerModel.isRight ? Icons.check : Icons.close;

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      // ignore pointer vai desativar o recurso de clique em um botao, por exemplo
      child: IgnorePointer(
        ignoring: widget.isDisabled,
        child: GestureDetector(
          onTap: () {
            // log(widget.answerModel.isRight.toString());
            widget.onTap(widget.answerModel.isRight);

            //devolvendo se a resposta eh certa ou errada
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? _selectedColorCardRight
                  : AppTheme.backgroundColors(
                      settingsController.currentAppTheme.brightness),
              borderRadius: BorderRadius.circular(10),
              border: Border.fromBorderSide(BorderSide(
                color: widget.isSelected
                    ? _selectedBorderCardRight
                    : AppColors.border,
              )),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.answerModel.title,
                    style: widget.isSelected
                        ? _selectedTextStyleRight
                        : AppTextStyles.body.copyWith(
                            color:
                                settingsController.currentAppTheme.primaryColor,
                          ),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: widget.isSelected
                        ? _selectedColorRight
                        : AppTheme.backgroundColors(
                            settingsController.currentAppTheme.brightness),
                    border: Border.fromBorderSide(BorderSide(
                      color: widget.isSelected
                          ? _selectedBorderRight
                          : AppColors.border,
                    )),
                  ),
                  child: widget.isSelected
                      ? Icon(
                          _selectedIconRight,
                          size: 16,
                          color: AppColors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
