// To parse this JSON data, do
//
//     final allFilteredExercises = allFilteredExercisesFromJson(jsonString);

import 'dart:convert';

List<AllFilteredExercises> allFilteredExercisesFromJson(String str) =>
    List<AllFilteredExercises>.from(
        json.decode(str).map((x) => AllFilteredExercises.fromJson(x)));

String allFilteredExercisesToJson(List<AllFilteredExercises> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllFilteredExercises {
  String bodyPart;
  Equipment equipment;
  String gifUrl;
  String id;
  String name;
  String target;
  List<String> secondaryMuscles;
  List<String> instructions;

  AllFilteredExercises({
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
  });

  factory AllFilteredExercises.fromJson(Map<String, dynamic> json) =>
      AllFilteredExercises(
        bodyPart: json["bodyPart"],
        equipment: equipmentValues.map[json["equipment"]]!,
        gifUrl: json["gifUrl"],
        id: json["id"],
        name: json["name"],
        target: json["target"],
        secondaryMuscles:
            List<String>.from(json["secondaryMuscles"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "bodyPart": bodyPart,
        "equipment": equipmentValues.reverse[equipment],
        "gifUrl": gifUrl,
        "id": id,
        "name": name,
        "target": target,
        "secondaryMuscles": List<dynamic>.from(secondaryMuscles.map((x) => x)),
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
      };
}

enum Equipment { ASSISTED }

final equipmentValues = EnumValues({"assisted": Equipment.ASSISTED});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
