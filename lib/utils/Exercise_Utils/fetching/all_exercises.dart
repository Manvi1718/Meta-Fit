import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:metafit/utils/exercise_utils/JsonParsing/all_exercises_json_parsing.dart';

Future<List<AllExercises>> fetchExercises() async {
  final exerciseApi = dotenv.env['EXERCISE_QUOTE_API'];
  var response = await http.get(
      Uri.parse('https://exercisedb.p.rapidapi.com/exercises?limit=25'),
      headers: {
        "X-RapidAPI-Key": exerciseApi.toString(),
        "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
      });
  final result = allExercisesFromJson(response.body);
  return result;
}
