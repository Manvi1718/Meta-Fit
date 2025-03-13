import 'package:flutter/material.dart';
import 'package:metafit/pages/exercises.dart';
import 'package:metafit/pages/favourite.dart';
import 'package:metafit/pages/home.dart';
import 'package:metafit/pages/nutrition.dart';
import 'package:metafit/utils/JsonParsing/all_exercises_json_parsing.dart';
import 'package:metafit/utils/all_exercises.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<AllExercises> allExercises;
  int selectedIndexOfNavigation = 0;

  PageController pageController = PageController();

  void onNavigationTapped(int index) {
    setState(() {
      selectedIndexOfNavigation = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  void initState() {
    allExercises = fetchExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MetaFit'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
        indicatorColor: const Color.fromARGB(108, 110, 110, 110),
        height: 70,
        elevation: 5,
        selectedIndex: selectedIndexOfNavigation,
        onDestinationSelected: (value) {
          onNavigationTapped(value);
        },
        destinations: [
          NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                size: 28,
              ),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(
                Icons.fitness_center_outlined,
                size: 28,
              ),
              label: 'Exercises'),
          NavigationDestination(
              icon: Icon(
                Icons.food_bank_outlined,
                size: 28,
              ),
              label: 'Nutrition'),
          NavigationDestination(
              icon: Icon(
                Icons.favorite_border_outlined,
                size: 28,
              ),
              label: 'Favourites'),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          HomePage(),
          ExercisesPage(),
          NutritionPage(),
          FavouritePage(),
        ],
      ),
    );
  }
}
