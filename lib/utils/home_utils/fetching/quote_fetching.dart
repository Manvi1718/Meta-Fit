import 'dart:convert';

import 'package:metafit/utils/home_utils/json_parsing/quote_json_parsing.dart';
import 'package:http/http.dart' as http;

Future<RandomQuote> fetchRandomQuote() async {
  final response = await http.get(
    Uri.parse('https://motivation-quotes4.p.rapidapi.com/api'),
    headers: {
      "X-RapidAPI-Key": "9572cc1ceamshb15636ae5cb5660p18b963jsn99ad2ef521aa",
      "X-RapidAPI-Host": "motivation-quotes4.p.rapidapi.com",
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    print(jsonData);
    return RandomQuote.fromJson(jsonData); // Correctly parse JSON
  } else {
    throw Exception("Failed to load quote");
  }
}
