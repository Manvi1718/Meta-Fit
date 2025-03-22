import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:metafit/utils/exercise_utils/searched_exercises.dart';
import 'package:metafit/utils/exercise_utils/filter.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';

void showCategory({required BuildContext context}) {
  final List<String> allBodyPartList = [
    "back",
    "cardio",
    "chest",
    "lower arms",
    "lower legs",
    "neck",
    "shoulders",
    "upper arms",
    "upper legs",
    "waist"
  ];
  final List<String> allEquipmentList = [
    "assisted",
    "band",
    "barbell",
    "body weight",
    "bosu ball",
    "cable",
    "dumbbell",
    "elliptical machine",
    "ez barbell",
    "hammer",
    "kettlebell",
    "leverage machine",
    "medicine ball",
    "olympic barbell",
    "resistance band",
    "roller",
    "rope",
    "skierg machine",
    "sled machine",
    "smith machine",
    "stability ball",
    "stationary bike",
    "stepmill machine",
    "tire",
    "trap bar",
    "upper body ergometer",
    "weighted",
    "wheel roller"
  ];
  final List<String> allTargetList = [
    "abductors",
    "abs",
    "adductors",
    "biceps",
    "calves",
    "cardiovascular system",
    "delts",
    "forearms",
    "glutes",
    "hamstrings",
    "lats",
    "levator scapulae",
    "pectorals",
    "quads",
    "serratus anterior",
    "spine",
    "traps",
    "triceps",
    "upper back"
  ];

  String? selectedBodyPart;
  String? selectedEquipment;
  String? selectedTarget;
  String selectedFilterType = "";
  String selectedFilterValue = "";
  TextEditingController searchController = TextEditingController();

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.8,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Colors.black.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Headings(
                                  text: 'Category Search',
                                  color: Colors.white,
                                  size: 28),
                              IconButton(
                                icon: Icon(Icons.search,
                                    color: Colors.orangeAccent),
                                onPressed: () {
                                  String searchText =
                                      searchController.text.trim();
                                  if (searchText.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchedExercises(
                                            nameOfExercise: searchText),
                                      ),
                                    ).then((_) => setState(
                                        () => searchController.clear()));
                                  } else if (selectedFilterType.isNotEmpty &&
                                      selectedFilterValue.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Filter(
                                            filter: selectedFilterType,
                                            value: selectedFilterValue),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: ModifiedText(
                                          text:
                                              'Please enter an exercise or select a filter before searching',
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: searchController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.orangeAccent,
                              decoration: InputDecoration(
                                hintText: "Search for an exercise...",
                                hintStyle: TextStyle(color: Colors.white54),
                                prefixIcon: Icon(Icons.fitness_center,
                                    color: Colors.white70),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          _buildDropdown("Select Body Part", selectedBodyPart,
                              allBodyPartList, (value) {
                            setState(() {
                              selectedBodyPart = value;
                              selectedFilterType = "bodyPart";
                              selectedFilterValue = value ?? "";
                            });
                          }),
                          SizedBox(height: 15),
                          _buildDropdown("Select Equipment", selectedEquipment,
                              allEquipmentList, (value) {
                            setState(() {
                              selectedEquipment = value;
                              selectedFilterType = "equipment";
                              selectedFilterValue = value ?? "";
                            });
                          }),
                          SizedBox(height: 15),
                          _buildDropdown("Select Target Muscle", selectedTarget,
                              allTargetList, (value) {
                            setState(() {
                              selectedTarget = value;
                              selectedFilterType = "target";
                              selectedFilterValue = value ?? "";
                            });
                          }),
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
    },
  );
}

Widget _buildDropdown(String label, String? value, List<String> items,
    ValueChanged<String?> onChanged) {
  return DropdownButtonFormField<String>(
    value: value,
    items: items
        .map((item) => DropdownMenuItem(
            value: item,
            child: Text(item, style: TextStyle(color: Colors.white))))
        .toList(),
    onChanged: onChanged,
    dropdownColor: Colors.black,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white54),
      border: OutlineInputBorder(),
    ),
  );
}
