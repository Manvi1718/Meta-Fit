import 'package:flutter/material.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/nutrition_utils/helpers/meal_plan_card.dart';
import 'package:metafit/provider/meal_plan_provider.dart';
import 'package:metafit/utils/nutrition_utils/helpers/dialogBox/show_dialog_deleteAll.dart';
import 'package:provider/provider.dart';

class ShowExistingMealPlan extends StatelessWidget {
  const ShowExistingMealPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final mealPlans = Provider.of<MealPlanProvider>(context).mealPlans;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Headings(text: 'Meal plans', color: Colors.white, size: 20),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          mealPlans.isEmpty
              ? Container()
              : IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: Color.fromARGB(255, 255, 143, 143), size: 28),
                  onPressed: () => confirmDeleteAll(context),
                ),
        ],
      ),
      body: mealPlans.isEmpty
          ? const Center(
              child: Text(
                'No meal plans yet. Generate one!',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 cards per row
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8, // Adjusted for better alignment
                ),
                itemCount: mealPlans.length,
                itemBuilder: (context, index) {
                  return MealPlanCard(
                    mealName: mealPlans[index],
                    index: index,
                  );
                },
              ),
            ),
    );
  }
}
