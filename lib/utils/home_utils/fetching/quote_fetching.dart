import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:metafit/utils/home_utils/json_parsing/quote_json_parsing.dart';
import 'package:http/http.dart' as http;

Future<RandomQuote> fetchRandomQuote() async {
  final quotesApi = dotenv.env['EXERCISE_QUOTE_API'];
  final response = await http.get(
    Uri.parse('https://motivation-quotes4.p.rapidapi.com/api'),
    headers: {
      "X-RapidAPI-Key": quotesApi.toString(),
      "X-RapidAPI-Host": "motivation-quotes4.p.rapidapi.com",
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return RandomQuote.fromJson(jsonData); // Correctly parse JSON
  } else {
    throw Exception("Failed to load quote");
  }
}
