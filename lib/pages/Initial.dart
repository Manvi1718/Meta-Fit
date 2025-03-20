import 'package:flutter/material.dart';
import 'package:metafit/pages/exercises.dart';
import 'package:metafit/pages/favourite.dart';
import 'package:metafit/pages/home.dart';
import 'package:metafit/pages/nutrition.dart';
import 'package:metafit/utils/Exercise_Utils/fetching/all_exercises.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/exercise_utils/JsonParsing/all_exercises_json_parsing.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<AllExercises>? allExercisesList;

  int selectedIndexOfNavigation = 0;

  PageController pageController = PageController();

  void onNavigationTapped(int index) {
    setState(() {
      selectedIndexOfNavigation = index;
    });
    pageController.jumpToPage(index);
  }

  void necessaryloading() async {
    final results = await Future.wait([
      fetchExercises(),
    ]);

    setState(() {
      allExercisesList = results[0];
    });
  }

  @override
  void initState() {
    super.initState();
    necessaryloading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Headings(
          text: 'MetaFit',
          color: Colors.white,
          size: 30,
        ),
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
          allExercisesList == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      ModifiedText(
                          text: 'Loading please wait....',
                          color: Colors.white54,
                          size: 15)
                    ],
                  ),
                )
              : ExercisesPage(
                  allExercises: allExercisesList!,
                ),
          NutritionPage(),
          FavouritePage(),
        ],
      ),
    );
  }
}
