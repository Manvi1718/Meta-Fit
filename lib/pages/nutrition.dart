import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:metafit/utils/nutrition_utils/generate_new_meal_plan.dart';
import 'package:metafit/utils/nutrition_utils/show_existing_meal_plan.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black, // Ensuring full dark theme
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: ButtonsTabBar(
                tabs: const [
                  Tab(
                    icon: Icon(Icons.food_bank_outlined, size: 22),
                    text: 'Meal Generator',
                  ),
                  Tab(
                    icon: Icon(Icons.list, size: 22),
                    text: 'Meal Plans',
                  ),
                ],
                unselectedBackgroundColor: Colors.transparent,
                labelStyle: const TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                borderWidth: 1.8,
                borderColor: Colors.greenAccent,
                radius: 12,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                buttonMargin: const EdgeInsets.symmetric(horizontal: 15),
                labelSpacing: 8,
                decoration: BoxDecoration(
                  color: Colors
                      .grey.shade900, // Dark background with green accents
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            GenerateNewMealPlan(),
            ShowExistingMealPlan(),
          ],
        ),
      ),
    );
  }
}
