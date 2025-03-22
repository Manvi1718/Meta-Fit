import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/exercise_utils/JsonParsing/all_exercises_json_parsing.dart';
import 'package:metafit/utils/exercise_utils/category_choosing.dart';
import 'package:metafit/utils/exercise_utils/description/exercise_description.dart';

class ExercisesPage extends StatefulWidget {
  final List<AllExercises> allExercises;
  const ExercisesPage({super.key, required this.allExercises});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final Set<int> likedExercises = {}; // Stores liked exercises

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme background
      appBar: AppBar(
        title: Headings(
          text: 'Exercises',
          color: Colors.white,
          size: 26,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showCategory(context: context);
            },
            icon: const Icon(Icons.category_rounded, color: Colors.orange),
            tooltip: "Filter by Category",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: widget.allExercises.length,
          itemBuilder: (context, index) {
            final exercise = widget.allExercises[index];
            final isLiked = likedExercises.contains(index);

            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08), // Glassmorphism
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
                  showExerciseDescription(context: context, exercise: exercise);
                },
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag:
                              'exerciseImage-${exercise.name}', // Smooth transition
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(12)),
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
                                      color: Colors.orange),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 250,
                                color: Colors.black26,
                                child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.white60, size: 50)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Headings(
                                text: '${index + 1}. ${exercise.name}',
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(height: 10),
                              ModifiedText(
                                text: '🎯 Target: ${exercise.target}',
                                color: Colors.orangeAccent,
                                size: 14,
                              ),
                              const SizedBox(height: 5),
                              ModifiedText(
                                text: '🏋️ Equipment: ${exercise.equipment}',
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
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.orange : Colors.white70,
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
