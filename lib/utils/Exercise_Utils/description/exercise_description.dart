import 'dart:ui'; // For blur effect
import 'package:flutter/material.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/exercise_utils/JsonParsing/all_exercises_json_parsing.dart';

void showExerciseDescription({
  required BuildContext context,
  required AllExercises exercise,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    backgroundColor: Colors.transparent, // Allows background blur
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.85),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Centered Exercise Image
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            exercise.gifUrl,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 200,
                                width: 200,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                    color: Colors.orange),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              height: 200,
                              width: 200,
                              color: Colors.black26,
                              child: Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.white60, size: 50),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Exercise Name
                      Headings(
                        text: exercise.name,
                        color: Colors.white,
                        size: 28,
                      ),
                      Divider(color: Colors.orange, thickness: 1.2),
                      SizedBox(height: 5),

                      // Exercise Details
                      _buildDetailRow(Icons.flag, "Target", exercise.target),
                      _buildDetailRow(
                          Icons.fitness_center, "Body Part", exercise.bodyPart),
                      _buildDetailRow(
                          Icons.handyman, "Equipment", exercise.equipment),
                      _buildDetailRow(Icons.layers, "Secondary Muscles",
                          exercise.secondaryMuscles.join(", ")),
                      SizedBox(height: 10),

                      // Instructions Header
                      Headings(
                          text: 'Instructions', color: Colors.orange, size: 22),
                      SizedBox(height: 5),

                      // Instructions Text
                      ModifiedText(
                        text: exercise.instructions.join("\n\n"),
                        color: Colors.white70,
                        size: 15,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

// Reusable Function for Exercise Details with Icons
Widget _buildDetailRow(IconData icon, String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, color: Colors.orange, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: ModifiedText(
            text: '$title: $value',
            color: Colors.white70,
            size: 15,
          ),
        ),
      ],
    ),
  );
}
