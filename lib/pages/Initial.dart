import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metafit/pages/exercises.dart';
import 'package:metafit/pages/favourite.dart';
import 'package:metafit/pages/home.dart';
import 'package:metafit/pages/nutrition.dart';
import 'package:metafit/pages/wrapper.dart';
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
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndexOfNavigation);
    necessaryLoading();

    // Listen to page swipes
    pageController.addListener(() {
      int newIndex = pageController.page?.round() ?? 0;
      if (newIndex != selectedIndexOfNavigation) {
        setState(() {
          selectedIndexOfNavigation = newIndex;
        });
      }
    });
  }

  Future<void> necessaryLoading() async {
    final results = await fetchExercises();
    setState(() {
      allExercisesList = results;
    });
  }

  void onNavigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("Logout", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Are you sure you want to log out?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Wrapper()),
                  (route) => false,
                );
              }
            },
            child:
                const Text("Logout", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
        actions: [
          IconButton(
            onPressed: confirmLogout,
            icon: const Icon(Icons.logout, color: Colors.deepOrange),
            tooltip: "Logout",
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF222222),
        indicatorColor: const Color(0xFF3A3A3A),
        height: 65,
        elevation: 6,
        selectedIndex: selectedIndexOfNavigation,
        onDestinationSelected: onNavigationTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 26),
            selectedIcon: Icon(Icons.home, size: 28, color: Colors.orange),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined, size: 26),
            selectedIcon:
                Icon(Icons.fitness_center, size: 28, color: Colors.orange),
            label: 'Exercises',
          ),
          NavigationDestination(
            icon: Icon(Icons.food_bank_outlined, size: 26),
            selectedIcon: Icon(Icons.food_bank, size: 28, color: Colors.orange),
            label: 'Nutrition',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_outlined, size: 26),
            selectedIcon: Icon(Icons.favorite, size: 28, color: Colors.orange),
            label: 'Favourites',
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          const HomePage(),
          allExercisesList == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: Colors.orange),
                      const SizedBox(height: 20),
                      ModifiedText(
                        text: 'Loading, please wait...',
                        color: Colors.white54,
                        size: 16,
                      ),
                    ],
                  ),
                )
              : ExercisesPage(allExercises: allExercisesList!),
          NutritionPage(),
          FavouritePage(),
        ],
      ),
    );
  }
}
