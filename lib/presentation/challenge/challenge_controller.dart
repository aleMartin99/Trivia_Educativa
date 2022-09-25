import 'package:flutter/foundation.dart';

class ChallengeController {
  final currentPageNotifier =
      ValueNotifier<int>(1); // notificador de pagina actual
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  int qtdRightAnswers = 0;
  int puntos = 0;
}
