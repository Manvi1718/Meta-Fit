import 'dart:ui'; // For blur effect
import 'package:flutter/material.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/exercise_utils/JsonParsing/all_filtered_exercises_json_parsing.dart';
import 'package:metafit/utils/exercise_utils/description/filtered_exercise_description.dart';
import 'package:metafit/utils/exercise_utils/fetching/filtered_exercises.dart';

class Filter extends StatefulWidget {
  final String filter;
  final String value;
  const Filter({super.key, required this.filter, required this.value});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<AllFilteredExercises>? filteredExercises;
  Set<int> likedExercises = {}; // Track liked exercises using index

  void loadFilteredExercises() async {
    var exercise = await fetchFilteredExercises(widget.filter, widget.value);
    setState(() {
      filteredExercises = exercise;
    });
  }

  @override
  void initState() {
    super.initState();
    loadFilteredExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme background
      appBar: AppBar(
        title: Headings(
          text: '${widget.filter} - ${widget.value}',
          color: Colors.white,
          size: 20,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: filteredExercises == null
            ? Center(
                child: CircularProgressIndicator(color: Colors.orangeAccent))
            : ListView.builder(
                itemCount: filteredExercises!.length,
                itemBuilder: (context, index) {
                  final exercise = filteredExercises![index];
                  final isLiked = likedExercises.contains(index);

                  return AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.08), // Glassmorphism effect
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        showFilteredExerciseDescription(
                          context: context,
                          exercise: exercise,
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag:
                                    'exerciseImage-${exercise.name}', // Smooth transition effect
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    exercise.gifUrl,
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return Container(
                                        height: 250,
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(
                                            color: Colors.orangeAccent),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Headings(
                                      text: '${exercise.name}',
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(height: 8),
                                    ModifiedText(
                                      text:
                                          '🎯 Target Muscles: ${exercise.target}',
                                      color: Colors.white70,
                                      size: 14,
                                    ),
                                    SizedBox(height: 4),
                                    ModifiedText(
                                      text:
                                          '🏋️ Equipment: ${exercise.equipment}',
                                      color: Colors.white70,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isLiked) {
                                    likedExercises.remove(index);
                                  } else {
                                    likedExercises.add(index);
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked
                                      ? Colors.orangeAccent
                                      : Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
