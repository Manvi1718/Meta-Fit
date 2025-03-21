import 'package:flutter/material.dart';

class MealPlanProvider extends ChangeNotifier {
  final List<String> _mealPlans = [];

  List<String> get mealPlans => _mealPlans;

  void addMealPlan(String? mealPlanName) {
    mealPlanName = mealPlanName ?? 'Custom Meal ${_mealPlans.length + 1}';
    _mealPlans.add(mealPlanName);
    notifyListeners();
  }

  void removeMealPlan(int index) {
    _mealPlans.removeAt(index);
    notifyListeners();
  }

  void removeAllPlans() {
    _mealPlans.clear();
    notifyListeners();
  }
}
