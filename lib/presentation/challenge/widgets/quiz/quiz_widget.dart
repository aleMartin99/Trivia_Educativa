import 'package:flutter/material.dart';

import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import 'package:trivia_educativa/presentation/challenge/widgets/quiz/quiz_image_widget.dart';

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

  void openGalleryView() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => GalleryWidget(imagen: widget.pregunta.imagen),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: (widget.pregunta.tiposDePregunta.contains('V o F'))
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 4),
                  child: Text(widget.pregunta.descripcion,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 24,
                          color: Theme.of(context).primaryIconTheme.color)),
                ),
                const SizedBox(
                  height: 24,
                ),
                GridView.count(
                    physics: const BouncingScrollPhysics(),
                    childAspectRatio: 1.11,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 16,
                    children: [
                      for (int i = 0; i < 2; i++)
                        AnswerWidget(
                          answerModel: answer(i),
                          isSelected: indexSelected == i,
                          isDisabled: indexSelected != -1,
                          isVoF:
                              widget.pregunta.tiposDePregunta.contains('V o F')
                                  ? true
                                  : false,
                          onTap: (valueIsRight) {
                            indexSelected = i;
                            setState(() {});
                            Future.delayed(const Duration(milliseconds: 100))
                                .then((_) =>
                                    widget.onAnswerSelected(valueIsRight));
                          },
                        )
                    ]),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (widget.pregunta.tiposDePregunta.contains('magen'))
                      ? Center(
                          child: InkWell(
                            child: Ink.image(
                              //ToDO put widgte.preg.imagen
                              image: NetworkImage(widget.pregunta.imagen),
                              height: 150,
                            ),
                            onTap: openGalleryView,
                          ),
                        )
                      : const Text(''),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 4),
                    child: Text(widget.pregunta.descripcion,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 24,
                            color: Theme.of(context).primaryIconTheme.color)),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  for (int i = 0;
                      (widget.pregunta.tiposDePregunta.contains('V o F'))
                          ? i < 2
                          : i < 4;
                      i++)
                    AnswerWidget(
                      answerModel: answer(i),
                      isSelected: indexSelected == i,
                      isDisabled: indexSelected != -1,
                      isVoF: widget.pregunta.tiposDePregunta.contains('V o F')
                          ? true
                          : false,
                      onTap: (valueIsRight) {
                        indexSelected = i;
                        setState(() {});
                        Future.delayed(const Duration(milliseconds: 100))
                            .then((_) => widget.onAnswerSelected(valueIsRight));
                      },
                    )
                ],
              ),
            ),
    );
  }
}
