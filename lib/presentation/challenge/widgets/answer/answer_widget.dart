import 'package:flutter/material.dart';

import 'package:trivia_educativa/data/models/models.dart';
import '../../../../core/app_icons.dart';
import '../../../../core/theme/text_theme.dart';
import '/../core/core.dart';

class AnswerWidget extends StatefulWidget {
  final AnswerModel answerModel;
  final bool isSelected;
  final bool isDisabled;
  final ValueChanged<bool> onTap;
  final bool isVoF;

  const AnswerWidget({
    Key? key,
    required this.answerModel,
    required this.onTap,
    required this.isVoF,
    this.isSelected = false,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  //todo create textstyle
  TextStyle get _selectedTextStyleRight => AppTextStyles.regularText16;

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
            child: (widget.isVoF)
                ? GestureDetector(
                    onTap: () {
                      widget.onTap(widget.answerModel.isRight);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: widget.isSelected
                            ? AppColors.purple
                            : AppTheme.backgroundColors(
                                Theme.of(context).brightness),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: FittedBox(
                                  child: CustomIconSVG(
                                    iconName:
                                        (widget.answerModel.title.contains('V'))
                                            ? AppIcons.like
                                            : AppIcons.dislike,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Flex(
                            direction: Axis.vertical,
                            children: [
                              Text(
                                widget.answerModel.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: widget.isSelected
                                    ? AppTextStyles.regularText16.copyWith(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white)
                                    : AppTextStyles.regularText16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: widget.isSelected
                          ? AppColors.purple
                          : AppTheme.backgroundColors(
                              Theme.of(context).brightness),
                      borderRadius: BorderRadius.circular(10),
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
                                : AppTextStyles.regularText16,
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: widget.isSelected
                                ? (Theme.of(context).brightness ==
                                        Brightness.light)
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
                  )),
      ),
    );
  }
}
