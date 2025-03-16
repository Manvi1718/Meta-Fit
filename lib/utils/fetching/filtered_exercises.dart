import 'package:http/http.dart' as http;
import 'package:metafit/utils/JsonParsing/all_filtered_exercises_json_parsing.dart';

Future<List<AllFilteredExercises>> fetchFilteredExercises(
    String filter, String value) async {
  var response = await http.get(
      Uri.parse(
          'https://exercisedb.p.rapidapi.com/exercises/$filter/$value?limit=2'),
      headers: {
        "X-RapidAPI-Key": "9572cc1ceamshb15636ae5cb5660p18b963jsn99ad2ef521aa",
        "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
      });
  final result = allFilteredExercisesFromJson(response.body);
  return result;
}
