import 'package:http/http.dart' as http;
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';

Future<MealPlanner> mealPlanFetch({
  required String time,
  required String calories,
  required String diet,
}) async {
  String apiKey = '7709a7e150ae493db0db4be830e1e49f';
  var response = await http.get(Uri.parse(
      'https://api.spoonacular.com/mealplanner/generate?timeFrame=$time&targetCalories=$calories&diet=$diet&apiKey=$apiKey'));
  final result = mealPlannerFromJson(response.body);
  return result;
}
