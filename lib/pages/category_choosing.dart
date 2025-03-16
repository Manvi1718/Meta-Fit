import 'package:flutter/material.dart';
import 'package:metafit/pages/filter.dart';
import 'package:metafit/utils/TextFunctions/Headings.dart';
import 'package:metafit/utils/TextFunctions/text.dart';

void showCategory({required BuildContext context}) {
  List<String> allBodyPartList = [
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
  List<String> allEquipmentList = [
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
  List<String> allTargetList = [
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

  // This variable will store the selected filter type and its value
  String selectedFilterType = "";
  String selectedFilterValue = "";

  showModalBottomSheet(
    isScrollControlled: true,
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
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Headings(
                            text: 'Category', color: Colors.white, size: 30),
                        IconButton(
                          icon: Icon(Icons.search,
                              color: const Color.fromARGB(255, 194, 249, 196)),
                          onPressed: () {
                            // Print or use the selected filter type and value
                            print("Selected Filter: $selectedFilterType");
                            print("Selected Value: $selectedFilterValue");
                            Filter(
                                filter: selectedFilterType,
                                value: selectedFilterValue);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ModifiedText(
                      text: 'Choose any one for smoother access',
                      color: const Color.fromARGB(110, 255, 255, 255),
                      size: 12,
                    ),
                    SizedBox(height: 15),
                    ModifiedText(
                        text: 'Body Part', color: Colors.white70, size: 18),
                    SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: selectedBodyPart,
                      items: allBodyPartList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                              style: TextStyle(color: Colors.white70)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBodyPart = value;
                          selectedFilterType = "bodyPart";
                          selectedFilterValue = value ?? "";
                        });
                      },
                      dropdownColor: Colors.black,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 15),
                    ModifiedText(
                        text: 'Equipments', color: Colors.white70, size: 18),
                    SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: selectedEquipment,
                      items: allEquipmentList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                              style: TextStyle(color: Colors.white70)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedEquipment = value;
                          selectedFilterType = "equipment";
                          selectedFilterValue = value ?? "";
                        });
                      },
                      dropdownColor: Colors.black,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 15),
                    ModifiedText(
                        text: 'Target', color: Colors.white70, size: 18),
                    SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: selectedTarget,
                      items: allTargetList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                              style: TextStyle(color: Colors.white70)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTarget = value;
                          selectedFilterType = "target";
                          selectedFilterValue = value ?? "";
                        });
                      },
                      dropdownColor: Colors.black,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}
