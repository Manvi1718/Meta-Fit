import 'package:flutter/material.dart';
import 'package:metafit/provider/meal_plan_provider.dart';
import 'package:provider/provider.dart';

void confirmDelete(BuildContext context, String mealPlanName) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Delete Meal Plan?",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        content: const Text(
            "Are you sure you want to remove this meal plan? This action cannot be undone.",
            style: TextStyle(color: Colors.white70, fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel",
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          TextButton(
            onPressed: () {
              Provider.of<MealPlanProvider>(context, listen: false)
                  .removeMealPlan(mealPlanName);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Meal plan deleted.")),
              );
            },
            child: const Text("Delete",
                style: TextStyle(color: Colors.redAccent, fontSize: 16)),
          ),
        ],
      );
    },
  );
}
