import 'package:flutter/material.dart';
import 'package:metafit/utils/nutrition_utils/meal_plan_provider.dart';
import 'package:provider/provider.dart';
import 'package:metafit/utils/nutrition_utils/fetching/meal_plan_fetching.dart';

class GenerateNewMealPlan extends StatefulWidget {
  const GenerateNewMealPlan({super.key});

  @override
  State<GenerateNewMealPlan> createState() => _GenerateNewMealPlanState();
}

class _GenerateNewMealPlanState extends State<GenerateNewMealPlan> {
  final TextEditingController caloriesController = TextEditingController();
  String? selectedDiet;
  String? selectedTimeFrame;
  bool isLoading = false;

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

  Future<void> generateMealPlan() async {
    if (caloriesController.text.isEmpty ||
        selectedDiet == null ||
        selectedTimeFrame == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields!')),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      await mealPlanFetch(
        time: selectedTimeFrame!.split(' ')[0].toLowerCase(),
        calories: caloriesController.text,
        diet: selectedDiet!.split(' ')[0].toLowerCase(),
      );

      setState(() => isLoading = false);

      // Add meal to provider
      Provider.of<MealPlanProvider>(context, listen: false).addMealPlan();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Meal Generated! 🎉'),
          content: const Text('See "Meal Plans" to view your generated plans.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Clear form fields
                caloriesController.clear();
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
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching meal plan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Create Your Meal Plan 🍽️',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            controller: caloriesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Target Calories 🌟',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedDiet,
            hint: const Text('Select Diet Type 🌿'),
            items: dietTypes
                .map((diet) => DropdownMenuItem(value: diet, child: Text(diet)))
                .toList(),
            onChanged: (value) => setState(() => selectedDiet = value),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedTimeFrame,
            hint: const Text('Select Time Frame ⏰'),
            items: timeFrames
                .map((frame) =>
                    DropdownMenuItem(value: frame, child: Text(frame)))
                .toList(),
            onChanged: (value) => setState(() => selectedTimeFrame = value),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: isLoading ? null : generateMealPlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Generate Plan ✅',
                      style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
