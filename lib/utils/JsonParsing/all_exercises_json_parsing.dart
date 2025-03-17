import 'dart:convert';

List<AllExercises> allExercisesFromJson(String str) => List<AllExercises>.from(
    json.decode(str).map((x) => AllExercises.fromJson(x)));

String allExercisesToJson(List<AllExercises> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllExercises {
  String bodyPart;
  String equipment;
  String gifUrl;
  String id;
  String name;
  String target;
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
        bodyPart: json["bodyPart"] ?? "Unknown",
        equipment: json["equipment"] ?? "Unknown",
        gifUrl: json["gifUrl"] ?? "",
        id: json["id"] ?? "",
        name: json["name"] ?? "Unknown Exercise",
        target: json["target"] ?? "Unknown",
        secondaryMuscles: json["secondaryMuscles"] != null
            ? List<String>.from(json["secondaryMuscles"])
            : [],
        instructions: json["instructions"] != null
            ? List<String>.from(json["instructions"])
            : [],
      );

  Map<String, dynamic> toJson() => {
        "bodyPart": bodyPart,
        "equipment": equipment,
        "gifUrl": gifUrl,
        "id": id,
        "name": name,
        "target": target,
        "secondaryMuscles": List<dynamic>.from(secondaryMuscles.map((x) => x)),
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
      };
}
