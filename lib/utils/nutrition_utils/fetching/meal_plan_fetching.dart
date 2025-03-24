import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';

Future<MealPlanner> mealPlanFetch({
  required String time,
  required String calories,
  required String diet,
}) async {
  final nutritionApi = dotenv.env['NUTRITION_API'].toString();
  var response = await http.get(Uri.parse(
      'https://api.spoonacular.com/mealplanner/generate?timeFrame=$time&targetCalories=$calories&diet=$diet&apiKey=$nutritionApi'));
  final result = mealPlannerFromJson(response.body);
  return result;
}
