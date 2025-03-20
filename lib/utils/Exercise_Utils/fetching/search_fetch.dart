import 'package:http/http.dart' as http;
import 'package:metafit/utils/exercise_utils/JsonParsing/all_exercises_json_parsing.dart';

Future<List<AllExercises>> fetchSearchedExercises(String name) async {
  var response = await http.get(
      Uri.parse(
          'https://exercisedb.p.rapidapi.com/exercises/name/$name?offset=0&limit=10'),
      headers: {
        "X-RapidAPI-Key": "9572cc1ceamshb15636ae5cb5660p18b963jsn99ad2ef521aa",
        "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
      });
  final result = allExercisesFromJson(response.body);
  return result;
}
