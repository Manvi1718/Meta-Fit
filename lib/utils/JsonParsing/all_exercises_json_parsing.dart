// To parse this JSON data, do
//
//     final allExercises = allExercisesFromJson(jsonString);

import 'dart:convert';

List<AllExercises> allExercisesFromJson(String str) => List<AllExercises>.from(
    json.decode(str).map((x) => AllExercises.fromJson(x)));

String allExercisesToJson(List<AllExercises> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllExercises {
  BodyPart bodyPart;
  String equipment;
  String gifUrl;
  String id;
  String name;
  Target target;
  List<String> secondaryMuscles;
  List<String> instructions;

  AllExercises({
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
  });

  factory AllExercises.fromJson(Map<String, dynamic> json) => AllExercises(
        bodyPart: bodyPartValues.map[json["bodyPart"]]!,
        equipment: json["equipment"],
        gifUrl: json["gifUrl"],
        id: json["id"],
        name: json["name"],
        target: targetValues.map[json["target"]]!,
        secondaryMuscles:
            List<String>.from(json["secondaryMuscles"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "bodyPart": bodyPartValues.reverse[bodyPart],
        "equipment": equipment,
        "gifUrl": gifUrl,
        "id": id,
        "name": name,
        "target": targetValues.reverse[target],
        "secondaryMuscles": List<dynamic>.from(secondaryMuscles.map((x) => x)),
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
      };
}

enum BodyPart { BACK, CHEST, WAIST }

final bodyPartValues = EnumValues(
    {"back": BodyPart.BACK, "chest": BodyPart.CHEST, "waist": BodyPart.WAIST});

enum Target { ABS, LATS, PECTORALS }

final targetValues = EnumValues(
    {"abs": Target.ABS, "lats": Target.LATS, "pectorals": Target.PECTORALS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
