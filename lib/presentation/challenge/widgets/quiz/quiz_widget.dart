import 'package:flutter/material.dart';

import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';

class QuizWidget extends StatefulWidget {
  final Pregunta pregunta;
  final ValueChanged<bool> onAnswerSelected;
  const QuizWidget({
    Key? key,
    required this.pregunta,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int indexSelected = -1;

  AnswerModel answer(int index) => widget.pregunta.answers[index];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // width: 257,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 4),
              child: Text(widget.pregunta.descripcion,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize:
                          24, //color: settingsController.currentAppTheme.primaryColor,
                      color: Theme.of(context).primaryIconTheme.color)),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          for (int i = 0; i < 4; i++)
            AnswerWidget(
              answerModel: answer(i),
              isSelected: indexSelected == i,
              isDisabled: indexSelected !=
                  -1, //se for diferente de -1, ele ja clicou em alguem, logo n pode mais
              onTap: (valueIsRight) {
                indexSelected = i;
                setState(() {});
                Future.delayed(const Duration(milliseconds: 100))
                    .then((_) => widget.onAnswerSelected(valueIsRight));
              },
            )
        ],
      ),
    );
  }
}
