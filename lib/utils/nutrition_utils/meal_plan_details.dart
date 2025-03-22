import 'package:flutter/material.dart';
import 'package:metafit/provider/meal_plan_provider.dart';
import 'package:metafit/utils/TextFunctions/headings.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';
import 'package:metafit/utils/nutrition_utils/plan_views/day_view.dart';
import 'package:metafit/utils/nutrition_utils/plan_views/week_view.dart';
import 'package:provider/provider.dart';

class MealPlanDetails extends StatelessWidget {
  final String mealPlanName;
  const MealPlanDetails({super.key, required this.mealPlanName});

  @override
  Widget build(BuildContext context) {
    MealPlanner? mealPlan =
        Provider.of<MealPlanProvider>(context, listen: false)
            .getMealPlanByName(mealPlanName);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Headings(text: mealPlanName, color: Colors.white, size: 22),
        backgroundColor: Colors.black,
        elevation: 2,
      ),
      body: mealPlan != null
          ? (mealPlan.week != null)
              ? WeekView(mealPlan: mealPlan)
              : DayView(
                  mealPlan: mealPlan,
                  dayName: 'Day',
                  dayMeal: true,
                  mealPlanName: mealPlan.mealPlanName,
                )
          : _buildErrorState(),
    );
  }

  Widget _buildErrorState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.white54),
          SizedBox(height: 10),
          Text(
            "Meal Plan Not Found!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
