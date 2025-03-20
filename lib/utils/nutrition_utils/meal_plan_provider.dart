import 'package:flutter/material.dart';

class MealPlanProvider extends ChangeNotifier {
  final List<String> _mealPlans = [];

  List<String> get mealPlans => _mealPlans;

  void addMealPlan() {
    _mealPlans.add('Custom Meal ${_mealPlans.length + 1}');
    notifyListeners();
  }

  void removeMealPlan(int index) {
    _mealPlans.removeAt(index);
    notifyListeners();
  }
}
