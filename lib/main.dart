import 'package:flutter/material.dart';
import 'package:metafit/pages/Initial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color.fromARGB(255, 33, 33, 33)),
      home: Home(),
    );
  }
}
