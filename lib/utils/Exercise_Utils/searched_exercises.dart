import 'package:flutter/material.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';
import 'package:metafit/utils/exercise_utils/JsonParsing/all_exercises_json_parsing.dart';
import 'package:metafit/utils/exercise_utils/description/exercise_description.dart';
import 'package:metafit/utils/exercise_utils/fetching/search_fetch.dart';

class SearchedExercises extends StatefulWidget {
  final String nameOfExercise;
  const SearchedExercises({super.key, required this.nameOfExercise});

  @override
  State<SearchedExercises> createState() => _SearchedExercisesState();
}

class _SearchedExercisesState extends State<SearchedExercises> {
  late String name;
  List<AllExercises>? searchedExercises;
  final Set<int> likedExercises = {}; // Store liked exercises

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
          text: 'Search Results for "$name"',
          color: Colors.white,
          size: 22,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
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
                      child: CircularProgressIndicator(color: Colors.orange))
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
                            final exercise = searchedExercises![index];
                            final isLiked = likedExercises.contains(index);

                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
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
                                  showExerciseDescription(
                                      context: context, exercise: exercise);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(12)),
                                          child: Image.network(
                                            exercise.gifUrl,
                                            height: 250,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (context, child, progress) {
                                              if (progress == null)
                                                return child;
                                              return Container(
                                                height: 250,
                                                alignment: Alignment.center,
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.orange),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                              height: 250,
                                              color: Colors.black26,
                                              child: Center(
                                                child: Icon(
                                                    Icons.image_not_supported,
                                                    color: Colors.white60,
                                                    size: 50),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Headings(
                                                text:
                                                    '${index + 1}. ${exercise.name}',
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(height: 10),
                                              ModifiedText(
                                                text:
                                                    '🎯 Target: ${exercise.target}',
                                                color: Colors.orangeAccent,
                                                size: 14,
                                              ),
                                              SizedBox(height: 5),
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
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            isLiked
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isLiked
                                                ? Colors.orange
                                                : Colors.white70,
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
          ],
        ),
      ),
    );
  }
}
