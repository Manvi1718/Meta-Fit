import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:metafit/firebase_options.dart';
import 'package:metafit/pages/initial.dart';
import 'package:metafit/provider/meal_plan_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
