import 'package:educational_quiz_app/core/app_text_styles.dart';
import 'package:educational_quiz_app/data/models/answer_model.dart';
import 'package:educational_quiz_app/data/models/pregunta_model.dart';
import 'package:educational_quiz_app/presentation/challenge/widgets/answer/answer_widget.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizWidget extends StatefulWidget {
  final Pregunta pregunta;
  //se foi selecionado uma resposta certa/errada
  // ValueChanged eh um tipo de funcao que devolve o valor atualizado da mudanca
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

//   List<AnswerWidget> lis() {
//     List<AnswerWidget> lisa = [];
//     for (int i = 0; i < 4; i++) {
//       lisa.add(AnswerWidget(
//         // answerModel: randomAnswers(),
//         answerModel: answer(i),
//         //answerModel: randomAnswers(),
//         isSelected: indexSelected == i,
//         isDisabled: indexSelected !=
//             -1, //se for diferente de -1, ele ja clicou em alguem, logo n pode mais
//         onTap: (valueIsRight) {
//           indexSelected = i;
//           //  log(valueIsRight.toString());

//           Future.delayed(const Duration(seconds: 1))
//               .then((_) => widget.onAnswerSelected(valueIsRight));
//         },
//       ));
//     }

//     lisa.shuffle();
//     return lisa;
//   }

//   List<AnswerWidget> listado = [];
//   @override
//   void initState() {
//     listado = lis();
//  setState(() {});
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

//       //* random items es el array que va a teer los indices de la lista desorganizados (shufle respuesta)

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 257,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                widget.pregunta.descripcion,
                style: AppTextStyles.heading.copyWith(
                  color: settingsController.currentAppTheme.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),

          //*imprime el listado regado ya

          // Column(
          //   children: listado,
          // )

          for (int i = 0; i < 4; i++)
            AnswerWidget(
              // answerModel: randomAnswers(),

              answerModel: answer(i),
              // answerModel: listado,

              //answerModel: randomAnswers(),
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
