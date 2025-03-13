import 'package:http/http.dart' as http;
import 'package:metafit/utils/JsonParsing/all_exercises_json_parsing.dart';

Future<AllExercises> fetchExercises() async {
  var response = await http
      .get(Uri.parse('https://exercisedb-api.vercel.app/api/v1/exercises'));
  final result = allExercisesFromJson(response.body);
  return result;
}
