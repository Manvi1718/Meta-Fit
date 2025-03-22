import 'package:flutter/material.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';
import 'package:shimmer/shimmer.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(43, 0, 0, 0),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Image Section with shimmer effect
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              baseUrl + meal.image,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[900],
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/placeholder_meal.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 Meal Info Section
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
                    _buildIconText(Icons.access_time, Colors.orange,
                        "${meal.readyInMinutes} min"),
                    const SizedBox(width: 15),
                    _buildIconText(Icons.people, Colors.green,
                        "${meal.servings} servings"),
                  ],
                ),
                const SizedBox(height: 12),

                // 🔹 View Recipe Button with gradient effect
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => launchURL(meal.sourceUrl),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.transparent,
                      elevation: 0,
                    ).copyWith(
                      backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return Colors.green; // Use a solid color
                      }),
                    ),
                    child: const Text(
                      "View Recipe",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Helper function for row items
  Widget _buildIconText(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
