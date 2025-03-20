import 'package:flutter/material.dart';
import 'package:metafit/pages/initial.dart';
import 'package:metafit/utils/nutrition_utils/meal_plan_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MealPlanProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color.fromARGB(255, 33, 33, 33)),
      home: Home(),
    );
  }
}
