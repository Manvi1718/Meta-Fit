import 'package:http/http.dart' as http;
import 'package:metafit/utils/exercise_utils/JsonParsing/all_filtered_exercises_json_parsing.dart';

Future<List<AllFilteredExercises>> fetchFilteredExercises(
  String filter,
  String value,
) async {
  try {
    var response = await http.get(
      Uri.parse(
          'https://exercisedb.p.rapidapi.com/exercises/$filter/$value?limit=25'),
      headers: {
        "X-RapidAPI-Key": "9572cc1ceamshb15636ae5cb5660p18b963jsn99ad2ef521aa",
        "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        // Warning: Empty response from API
        return [];
      }
      return allFilteredExercisesFromJson(response.body);
    } else if (response.statusCode == 429) {
      // API Rate Limit Exceeded! Try again later.
      return [];
    } else {
      // API Error
      return [];
    }
  } catch (e) {
    // Fetch Error
    return [];
  }
}
