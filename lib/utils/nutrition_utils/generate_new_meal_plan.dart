import 'package:flutter/material.dart';
import 'package:metafit/provider/meal_plan_provider.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';
import 'package:provider/provider.dart';
import 'package:metafit/utils/nutrition_utils/fetching/meal_plan_fetching.dart';

class GenerateNewMealPlan extends StatefulWidget {
  const GenerateNewMealPlan({super.key});

  @override
  State<GenerateNewMealPlan> createState() => _GenerateNewMealPlanState();
}

class _GenerateNewMealPlanState extends State<GenerateNewMealPlan> {
  late final TextEditingController mealNameController;
  late final TextEditingController caloriesController;
  String? selectedDiet;
  String? selectedTimeFrame;
  bool isLoading = false;

  MealPlanner? customPlan;

  final List<String> timeFrames = ['Day ⏰', 'Week 🗓'];
  final List<String> dietTypes = [
    'Gluten Free 🌿',
    'Ketogenic 🍔',
    'Vegetarian 🌱',
    'Lacto-Vegetarian 🍕',
    'Ovo-Vegetarian 🥚',
    'Vegan 🌾',
    'Pescetarian 🌟',
    'Paleo 🥜',
    'Primal 🌮',
    'Low FODMAP 🥒',
    'Whole30 🥣'
  ];

  @override
  void initState() {
    mealNameController = TextEditingController();
    caloriesController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mealNameController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

  Future<void> generateMealPlan() async {
    if (caloriesController.text.isEmpty ||
        selectedDiet == null ||
        selectedTimeFrame == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all required fields!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      customPlan = await mealPlanFetch(
        time: selectedTimeFrame!.split(' ')[0].toLowerCase(),
        calories: caloriesController.text,
        diet: selectedDiet!.split(' ')[0].toLowerCase(),
      );

      setState(() => isLoading = false);

      if (customPlan != null) {
        Provider.of<MealPlanProvider>(context, listen: false)
            .addMealPlan(mealNameController.text, customPlan!);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text('Meal Generated! 🎉',
                style: TextStyle(color: Colors.white)),
            content: const Text(
                'See "Meal Plans" to view your generated plans.',
                style: TextStyle(color: Colors.white70)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Clear form fields
                  caloriesController.clear();
                  mealNameController.clear();
                  setState(() {
                    selectedDiet = null;
                    selectedTimeFrame = null;
                  });
                },
                child: const Text('OK', style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Error: Meal plan could not be created.")),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching meal plan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Headings(
              text: 'Create Your Meal Plan 🍽️',
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(height: 15),
            buildTextField(mealNameController, 'Name of the Meal 🍽️'),
            const SizedBox(height: 15),
            buildTextField(caloriesController, 'Target Calories 🌟',
                inputType: TextInputType.number),
            const SizedBox(height: 15),
            buildDropdown('Select Diet Type 🌿', dietTypes, selectedDiet,
                (value) => setState(() => selectedDiet = value)),
            const SizedBox(height: 15),
            buildDropdown('Select Time Frame ⏰', timeFrames, selectedTimeFrame,
                (value) => setState(() => selectedTimeFrame = value)),
            const SizedBox(height: 25),
            Center(
              child: ElevatedButton(
                onPressed: isLoading ? null : generateMealPlan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Generate Plan ✅',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      {TextInputType inputType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget buildDropdown(String hint, List<String> items, String? value,
      void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint, style: const TextStyle(color: Colors.white70)),
      items: items
          .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item, style: const TextStyle(color: Colors.white))))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
