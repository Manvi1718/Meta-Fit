import 'dart:convert';

List<AllFilteredExercises> allFilteredExercisesFromJson(String str) =>
    List<AllFilteredExercises>.from(
        json.decode(str).map((x) => AllFilteredExercises.fromJson(x)));

String allFilteredExercisesToJson(List<AllFilteredExercises> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllFilteredExercises {
  String bodyPart;
  String equipment;
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
        bodyPart: json["bodyPart"] ?? "Unknown", // Handle missing data
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
