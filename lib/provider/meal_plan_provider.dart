import 'package:flutter/material.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';

class MealPlanProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _mealPlans = [];

  List<Map<String, dynamic>> get mealPlans => _mealPlans;

  void addMealPlan(String mealPlanName, MealPlanner? mealPlan) {
    _mealPlans.add({
      'name': mealPlanName.isNotEmpty
          ? mealPlanName
          : 'Custom Meal ${_mealPlans.length + 1}',
      'plan': mealPlan,
    });
    notifyListeners();
  }

  MealPlanner? getMealPlanByName(String mealPlanName) {
    for (var meal in _mealPlans) {
      if (meal['name'] == mealPlanName) {
        return meal['plan'] as MealPlanner?;
      }
    }
    return null; // Return null if not found
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
