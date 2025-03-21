import 'package:flutter/material.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';
import 'package:url_launcher/url_launcher.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  Future<void> launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  final String baseUrl = "https://spoonacular.com/recipeImages/";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10), // Space between cards
      decoration: BoxDecoration(
        color: Colors.grey[900], // Dark theme background
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(44, 0, 0, 0),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              baseUrl + meal.image,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image loaded successfully
                }
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.black54,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color:
                        Colors.white, // Loading indicator while fetching image
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.black54,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported,
                    size: 80, color: Colors.white),
              ),
            ),
          ),

          // Meal Info Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        color: Colors.orange, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      "${meal.readyInMinutes} min",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 15),
                    const Icon(Icons.people, color: Colors.green, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      "${meal.servings} servings",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // View Recipe Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      launchURL(meal.sourceUrl);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "View Recipe",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
