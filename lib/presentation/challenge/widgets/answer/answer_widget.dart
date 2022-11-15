import 'package:flutter/material.dart';

import 'package:trivia_educativa/data/models/models.dart';
import '/../core/core.dart';

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
  // Color get _selectedBorderRight =>
  //     widget.answerModel.isRight ? AppColors.lightGreen : AppColors.lightRed;

  TextStyle get _selectedTextStyleRight => TextStyle(
      fontFamily: 'PNRegular',
      fontSize: 16,
      color: Theme.of(context).primaryIconTheme.color
      // fontWeight: FontWeight.w100,
      );

  IconData get _selectedIconRight =>
      widget.answerModel.isRight ? Icons.close : Icons.close;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: IgnorePointer(
        ignoring: widget.isDisabled,
        child: GestureDetector(
          onTap: () {
            widget.onTap(widget.answerModel.isRight);
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? AppColors.purple
                  : AppTheme.backgroundColors(Theme.of(context).brightness),
              borderRadius: BorderRadius.circular(10),
              // border: Border.fromBorderSide(BorderSide(
              //     color: widget.isSelected
              //         ? (Theme.of(context).brightness == Brightness.light)
              //             ? AppColors.border
              //             : AppColors.black
              //         : AppColors.border // : AppColors.border,
              //     )),
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
                        ? _selectedTextStyleRight.copyWith(
                            color: AppColors.white)
                        : AppTextStyles.body.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).primaryIconTheme.color,
                          ),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: widget.isSelected
                        ? (Theme.of(context).brightness == Brightness.light)
                            ? AppTheme.backgroundColors(
                                Theme.of(context).brightness)
                            : AppColors.lightPurple
                        : AppTheme.backgroundColors(
                            Theme.of(context).brightness),
                    border: Border.fromBorderSide(BorderSide(
                      color: widget.isSelected
                          ? AppColors.purple
                          : AppColors.border,
                    )),
                  ),
                  child: widget.isSelected
                      ? Icon(
                          _selectedIconRight,
                          size: 16,
                          color: AppColors.purple,
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
