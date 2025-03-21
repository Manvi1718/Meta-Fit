import 'package:flutter/material.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';
import 'package:metafit/utils/nutrition_utils/plan_views/day_view.dart';

class WeekView extends StatelessWidget {
  final MealPlanner mealPlan;
  const WeekView({super.key, required this.mealPlan});

  @override
  Widget build(BuildContext context) {
    final week = mealPlan.week!;
    final days = {
      "Monday": week.monday,
      "Tuesday": week.tuesday,
      "Wednesday": week.wednesday,
      "Thursday": week.thursday,
      "Friday": week.friday,
      "Saturday": week.saturday,
      "Sunday": week.sunday,
    };

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: days.length,
      itemBuilder: (context, index) {
        String dayName = days.keys.elementAt(index);
        Day dayPlan = days[dayName]!;

        return Card(
          color: Colors.grey[900],
          child: ListTile(
            title: Text(dayName, style: const TextStyle(color: Colors.white)),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DayView(
                  mealPlan: MealPlanner(
                      meals: dayPlan.meals, nutrients: dayPlan.nutrients),
                  dayName: dayName,
                  dayMeal: false,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
