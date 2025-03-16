import 'package:flutter/material.dart';
import 'package:metafit/utils/JsonParsing/all_exercises_json_parsing.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';

class ExercisesPage extends StatelessWidget {
  final List<AllExercises> allExercises;
  const ExercisesPage({super.key, required this.allExercises});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // color: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Headings(text: 'Exercises', color: Colors.white54, size: 25),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allExercises.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            allExercises[index].gifUrl,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Headings(
                              text: allExercises[index].name,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            ModifiedText(
                              text:
                                  'Target Muscles : ${allExercises[index].target.name}',
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ModifiedText(
                                  text:
                                      'Equipment : ${allExercises[index].equipment}',
                                  color: Colors.white,
                                  size: 12,
                                ),
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
