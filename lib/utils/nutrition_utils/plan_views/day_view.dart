import 'package:flutter/material.dart';
import 'package:metafit/utils/TextFunctions/headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';
import 'package:metafit/utils/nutrition_utils/plan_views/meal_nutrients_card.dart';

class DayView extends StatelessWidget {
  final bool dayMeal;
  final MealPlanner mealPlan;
  final String dayName;
  final String mealPlanName;

  const DayView({
    super.key,
    required this.mealPlan,
    required this.dayName,
    required this.dayMeal,
    required this.mealPlanName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: dayMeal == false
          ? AppBar(
              backgroundColor: Colors.black,
              elevation: 2,
              title: Headings(
                  text: "$mealPlanName - $dayName",
                  color: Colors.white,
                  size: 22),
            )
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("🔥 Nutritional Breakdown"),
            const SizedBox(height: 10),
            mealPlan.nutrients != null
                ? _buildNutritionalInfo(mealPlan.nutrients!)
                : _buildNoDataMessage("No nutrition data available."),
            const SizedBox(height: 30),
            _buildSectionTitle("🍽️ Meals"),
            const SizedBox(height: 10),
            mealPlan.meals != null && mealPlan.meals!.isNotEmpty
                ? Column(
                    children: mealPlan.meals!
                        .map((meal) => MealCard(meal: meal))
                        .toList(),
                  )
                : _buildNoDataMessage("No meals found for this day."),
          ],
        ),
      ),
    );
  }

  // 🔹 Section Title Widget
  Widget _buildSectionTitle(String text) {
    return Headings(text: text, color: Colors.white, size: 20);
  }

  // 🔹 Nutritional Info Widget
  Widget _buildNutritionalInfo(Nutrients nutrients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNutrientItem("🔥 Calories", "${nutrients.calories} kcal"),
        _buildNutrientItem("💪 Protein", "${nutrients.protein} g"),
        _buildNutrientItem("🍔 Fat", "${nutrients.fat} g"),
        _buildNutrientItem("🍞 Carbs", "${nutrients.carbohydrates} g"),
      ],
    );
  }

  // 🔹 Single Nutrient Item
  Widget _buildNutrientItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child:
          ModifiedText(text: "$label: $value", color: Colors.yellow, size: 16),
    );
  }

  // 🔹 No Data Message
  Widget _buildNoDataMessage(String message) {
    return Center(
      child: ModifiedText(text: message, color: Colors.white54, size: 16),
    );
  }
}
