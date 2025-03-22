import 'package:flutter/material.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';
import 'package:metafit/utils/nutrition_utils/plan_views/day_view.dart';

class WeekView extends StatelessWidget {
  final MealPlanner mealPlan;
  const WeekView({super.key, required this.mealPlan});

  @override
  Widget build(BuildContext context) {
    final week = mealPlan.week;
    if (week == null) {
      return _buildNoDataMessage();
    }

    final days = {
      "Monday": week.monday,
      "Tuesday": week.tuesday,
      "Wednesday": week.wednesday,
      "Thursday": week.thursday,
      "Friday": week.friday,
      "Saturday": week.saturday,
      "Sunday": week.sunday,
    };

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: days.length,
        itemBuilder: (context, index) {
          String dayName = days.keys.elementAt(index);
          Day? dayPlan = days[dayName];

          return dayPlan != null
              ? _buildDayCard(context, dayName, dayPlan)
              : _buildEmptyDayCard(dayName);
        },
      ),
    );
  }

  // 🔹 Builds a styled card for each day
  Widget _buildDayCard(BuildContext context, String dayName, Day dayPlan) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DayView(
            mealPlan: MealPlanner(
                meals: dayPlan.meals,
                nutrients: dayPlan.nutrients,
                mealPlanName: mealPlan.mealPlanName),
            dayName: dayName,
            dayMeal: false,
            mealPlanName: mealPlan.mealPlanName,
          ),
        ),
      ),
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          leading:
              Icon(Icons.calendar_today, color: Colors.orangeAccent, size: 30),
          title: Text(
            dayName,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              color: Colors.white70, size: 18),
        ),
      ),
    );
  }

  // 🔹 Builds an empty state card if day data is missing
  Widget _buildEmptyDayCard(String dayName) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: Icon(Icons.error_outline, color: Colors.redAccent, size: 30),
        title: Text(
          "$dayName (No Data)",
          style: const TextStyle(color: Colors.white54, fontSize: 16),
        ),
      ),
    );
  }

  // 🔹 Handles case when no weekly data is available
  Widget _buildNoDataMessage() {
    return const Center(
      child: Text(
        "No weekly meal plan available.",
        style: TextStyle(color: Colors.white70, fontSize: 18),
      ),
    );
  }
}
