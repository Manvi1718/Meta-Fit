import 'package:flutter/material.dart';
import 'package:metafit/utils/TextFunctions/headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';
import 'package:metafit/utils/nutrition_utils/plan_views/meal_nutrients_card.dart';

class DayView extends StatelessWidget {
  final bool dayMeal;
  final MealPlanner mealPlan;
  final String dayName;
  final String mealPlanName; // ✅ Add this

  const DayView({
    super.key,
    required this.mealPlan,
    required this.dayName,
    required this.dayMeal,
    required this.mealPlanName, // ✅ Add this
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: dayMeal == false
          ? AppBar(
              title: Headings(
                  text: "$mealPlanName - $dayName",
                  color: Colors.white,
                  size: 25),
            )
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headings(
                text: "Nutritional Breakdown", color: Colors.white, size: 20),
            const SizedBox(height: 10),
            if (mealPlan.nutrients != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModifiedText(
                      text: "🔥 Calories: ${mealPlan.nutrients!.calories} kcal",
                      color: Colors.yellow,
                      size: 15),
                  ModifiedText(
                      text: "💪 Protein: ${mealPlan.nutrients!.protein} g",
                      color: Colors.yellow,
                      size: 15),
                  ModifiedText(
                      text: "🍔 Fat: ${mealPlan.nutrients!.fat} g",
                      color: Colors.yellow,
                      size: 15),
                  ModifiedText(
                      text: "🍞 Carbs: ${mealPlan.nutrients!.carbohydrates} g",
                      color: Colors.yellow,
                      size: 15),
                ],
              ),
            const SizedBox(height: 30),
            Headings(text: "🍽️ Meals", color: Colors.white, size: 20),
            const SizedBox(height: 10),
            if (mealPlan.meals != null)
              ...mealPlan.meals!.map((meal) => MealCard(meal: meal)),
          ],
        ),
      ),
    );
  }
}
