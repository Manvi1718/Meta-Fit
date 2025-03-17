import 'package:flutter/material.dart';
import 'package:metafit/utils/JsonParsing/all_filtered_exercises_json_parsing.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/fetching/filtered_exercises.dart';
import 'package:metafit/utils/filtered_exercise_description.dart';

class Filter extends StatefulWidget {
  final String filter;
  final String value;
  const Filter({super.key, required this.filter, required this.value});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<AllFilteredExercises>? filteredExercises;

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
      appBar: AppBar(
        title: Headings(
            text: '${widget.filter} - ${widget.value}',
            color: Colors.white,
            size: 20),
      ),
      body: Container(
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
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: filteredExercises == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: filteredExercises!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showFilteredExerciseDescription(
                              context: context,
                              exercise: filteredExercises![index],
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
                                    filteredExercises![index].gifUrl,
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
                                      text:
                                          '${index + 1} - ${filteredExercises![index].name}',
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    ModifiedText(
                                      text:
                                          '🎯 Target Muscles : ${filteredExercises![index].target}',
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ModifiedText(
                                          text:
                                              '🏋️ Equipment : ${filteredExercises![index].equipment}',
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
