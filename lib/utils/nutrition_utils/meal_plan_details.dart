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
      appBar: AppBar(
        title: Headings(text: mealPlanName, color: Colors.white, size: 25),
      ),
      body: mealPlan != null
          ? (mealPlan.week != null)
              ? WeekView(mealPlan: mealPlan)
              : DayView(
                  mealPlan: mealPlan,
                  dayName: 'Day',
                  dayMeal: true,
                )
          : const Center(
              child: Text("Meal Plan Not Found!",
                  style: TextStyle(color: Colors.white))),
    );
  }
}
