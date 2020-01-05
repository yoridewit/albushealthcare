import 'package:flutter/material.dart';

class Weights with ChangeNotifier {
  int _weightInKg;

  int get weight {
    return _weightInKg;
  }

  void changeWeight(weightInKg) {
    _weightInKg = weightInKg;
    notifyListeners();
  }

  void deleteValue() {
    _weightInKg = null;
    notifyListeners();
  }
}
