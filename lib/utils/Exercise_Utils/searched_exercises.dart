import 'package:flutter/material.dart';
import 'package:metafit/utils/Exercise_Utils/JsonParsing/all_exercises_json_parsing.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/Exercise_Utils/description/exercise_description.dart';
import 'package:metafit/utils/Exercise_Utils/fetching/search_fetch.dart';

class SearchedExercises extends StatefulWidget {
  final String nameOfExercise;
  const SearchedExercises({super.key, required this.nameOfExercise});

  @override
  State<SearchedExercises> createState() => _SearchedExercisesState();
}

class _SearchedExercisesState extends State<SearchedExercises> {
  late String name;
  List<AllExercises>? searchedExercises;

  @override
  void initState() {
    super.initState();
    loadSearchedExercises(widget.nameOfExercise);
  }

  void loadSearchedExercises(String nameOfExercise) async {
    name = widget.nameOfExercise;
    var exercise = await fetchSearchedExercises(name);
    setState(() {
      searchedExercises = exercise;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Headings(
          text: 'Search Result for $name',
          color: Colors.white,
          size: 20,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
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
            SizedBox(height: 15),
            Expanded(
              child: searchedExercises == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : searchedExercises!.isEmpty
                      ? Center(
                          child: ModifiedText(
                            text: '😔 No Exercise found',
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      : ListView.builder(
                          itemCount: searchedExercises!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showExerciseDescription(
                                  context: context,
                                  exercise: searchedExercises![index],
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        searchedExercises![index].gifUrl,
                                        height: 250,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Headings(
                                          text:
                                              '${index + 1} - ${searchedExercises![index].name}',
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(height: 12),
                                        ModifiedText(
                                          text:
                                              '🎯 Target Muscles : ${searchedExercises![index].target}',
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        SizedBox(height: 2),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ModifiedText(
                                              text:
                                                  '🏋️ Equipment : ${searchedExercises![index].equipment}',
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
      ),
    );
  }
}
