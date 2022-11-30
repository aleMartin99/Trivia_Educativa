import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  int _currentPage = 0;

  // ignore: unnecessary_getters_setters
  int get currentPage => _currentPage;
  set currentPage(int value) => _currentPage = value;

  void updateCurrentPage(int index) {
    if (index != currentPage) {
      _currentPage = index;
      notifyListeners();
    }
  }
}
