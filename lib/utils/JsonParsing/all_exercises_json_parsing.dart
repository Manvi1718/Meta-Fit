// To parse this JSON data, do
//
//     final allExercises = allExercisesFromJson(jsonString);

import 'dart:convert';

AllExercises allExercisesFromJson(String str) =>
    AllExercises.fromJson(json.decode(str));

String allExercisesToJson(AllExercises data) => json.encode(data.toJson());

class AllExercises {
  bool success;
  Data data;

  AllExercises({
    required this.success,
    required this.data,
  });

  factory AllExercises.fromJson(Map<String, dynamic> json) => AllExercises(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  dynamic previousPage;
  String nextPage;
  int totalPages;
  int totalExercises;
  int currentPage;
  List<Exercise> exercises;

  Data({
    required this.previousPage,
    required this.nextPage,
    required this.totalPages,
    required this.totalExercises,
    required this.currentPage,
    required this.exercises,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        previousPage: json["previousPage"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
        totalExercises: json["totalExercises"],
        currentPage: json["currentPage"],
        exercises: List<Exercise>.from(
            json["exercises"].map((x) => Exercise.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "previousPage": previousPage,
        "nextPage": nextPage,
        "totalPages": totalPages,
        "totalExercises": totalExercises,
        "currentPage": currentPage,
        "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
      };
}

class Exercise {
  String exerciseId;
  String name;
  String gifUrl;
  List<String> instructions;
  List<String> targetMuscles;
  List<String> bodyParts;
  List<Equipment> equipments;
  List<String> secondaryMuscles;

  Exercise({
    required this.exerciseId,
    required this.name,
    required this.gifUrl,
    required this.instructions,
    required this.targetMuscles,
    required this.bodyParts,
    required this.equipments,
    required this.secondaryMuscles,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        exerciseId: json["exerciseId"],
        name: json["name"],
        gifUrl: json["gifUrl"],
        instructions: List<String>.from(json["instructions"].map((x) => x)),
        targetMuscles: List<String>.from(json["targetMuscles"].map((x) => x)),
        bodyParts: List<String>.from(json["bodyParts"].map((x) => x)),
        equipments: List<Equipment>.from(
            json["equipments"].map((x) => equipmentValues.map[x]!)),
        secondaryMuscles:
            List<String>.from(json["secondaryMuscles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "exerciseId": exerciseId,
        "name": name,
        "gifUrl": gifUrl,
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
        "targetMuscles": List<dynamic>.from(targetMuscles.map((x) => x)),
        "bodyParts": List<dynamic>.from(bodyParts.map((x) => x)),
        "equipments": List<dynamic>.from(
            equipments.map((x) => equipmentValues.reverse[x])),
        "secondaryMuscles": List<dynamic>.from(secondaryMuscles.map((x) => x)),
      };
}

enum Equipment { BODY_WEIGHT }

final equipmentValues = EnumValues({"body weight": Equipment.BODY_WEIGHT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
