import 'package:flutter/material.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/exercise_utils/JsonParsing/all_filtered_exercises_json_parsing.dart';

void showFilteredExerciseDescription({
  required BuildContext context,
  required AllFilteredExercises exercise,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows full height if needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5, // Starts at 50% of screen height
        minChildSize: 0.4, // Can shrink to 40%
        maxChildSize: 0.9, // Can expand to 90% of screen height
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController, // Enables smooth scrolling
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        exercise.gifUrl,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Headings(text: exercise.name, color: Colors.white, size: 30),
                  SizedBox(height: 5),
                  ModifiedText(
                    text: '🎯 Target : ${exercise.target}',
                    color: const Color.fromARGB(255, 251, 237, 108),
                    size: 15,
                  ),
                  SizedBox(height: 5),
                  ModifiedText(
                    text: '💪Body Part : ${exercise.bodyPart}',
                    color: Colors.yellow,
                    size: 15,
                  ),
                  SizedBox(height: 5),
                  ModifiedText(
                    text: '🏋️ Equipment : ${exercise.equipment}',
                    color: Colors.yellow,
                    size: 15,
                  ),
                  SizedBox(height: 5),
                  ModifiedText(
                    text:
                        '🔄 Secondary Muscles : ${exercise.secondaryMuscles.join(", ")}',
                    color: Colors.yellow,
                    size: 15,
                  ),
                  SizedBox(height: 5),
                  Headings(text: 'Instructions', color: Colors.white, size: 20),
                  SizedBox(height: 5),
                  ModifiedText(
                    text: exercise.instructions.join(" "),
                    color: Colors.white70,
                    size: 14,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
