import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier {
  int index = 0;

  void change(int i) {
    index = i;
    notifyListeners();
  }
}
