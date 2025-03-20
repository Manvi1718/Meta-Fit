import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:metafit/utils/nutrition_utils/generate_new_meal_plan.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';
import 'package:metafit/utils/nutrition_utils/show_existing_meal_plan.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  List<MealPlanner>? allNutritionPlans;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ButtonsTabBar(
                tabs: const [
                  Tab(
                      icon: Icon(Icons.food_bank_outlined),
                      text: 'Meal Generator'),
                  Tab(icon: Icon(Icons.list), text: 'Meal Plans'),
                ],
                backgroundColor: Colors.green,
                unselectedBackgroundColor: Colors.grey.shade900,
                labelStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(color: Colors.grey.shade400),
                borderWidth: 1.5,
                borderColor: Colors.greenAccent,
                radius: 15,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                buttonMargin: const EdgeInsets.symmetric(horizontal: 25),
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
