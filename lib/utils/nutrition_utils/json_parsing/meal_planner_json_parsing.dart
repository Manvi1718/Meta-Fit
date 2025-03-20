import 'dart:convert';

MealPlanner mealPlannerFromJson(String str) =>
    MealPlanner.fromJson(json.decode(str));

String mealPlannerToJson(MealPlanner data) => json.encode(data.toJson());

class MealPlanner {
  Week? week; // For "week" time frame
  List<Meal>? meals; // For "day" time frame
  Nutrients? nutrients; // For "day" time frame

  MealPlanner({
    this.week,
    this.meals,
    this.nutrients,
  });

  factory MealPlanner.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("week")) {
      // Week-based meal plan
      return MealPlanner(week: Week.fromJson(json["week"]));
    } else if (json.containsKey("meals") && json.containsKey("nutrients")) {
      // Day-based meal plan
      return MealPlanner(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
        nutrients: Nutrients.fromJson(json["nutrients"]),
      );
    } else {
      throw Exception("Invalid meal plan format");
    }
  }

  Map<String, dynamic> toJson() {
    if (week != null) {
      return {"week": week!.toJson()};
    } else if (meals != null && nutrients != null) {
      return {
        "meals": List<dynamic>.from(meals!.map((x) => x.toJson())),
        "nutrients": nutrients!.toJson(),
      };
    } else {
      return {};
    }
  }
}

class Week {
  Day monday;
  Day tuesday;
  Day wednesday;
  Day thursday;
  Day friday;
  Day saturday;
  Day sunday;

  Week({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory Week.fromJson(Map<String, dynamic> json) => Week(
        monday: Day.fromJson(json["monday"]),
        tuesday: Day.fromJson(json["tuesday"]),
        wednesday: Day.fromJson(json["wednesday"]),
        thursday: Day.fromJson(json["thursday"]),
        friday: Day.fromJson(json["friday"]),
        saturday: Day.fromJson(json["saturday"]),
        sunday: Day.fromJson(json["sunday"]),
      );

  Map<String, dynamic> toJson() => {
        "monday": monday.toJson(),
        "tuesday": tuesday.toJson(),
        "wednesday": wednesday.toJson(),
        "thursday": thursday.toJson(),
        "friday": friday.toJson(),
        "saturday": saturday.toJson(),
        "sunday": sunday.toJson(),
      };
}

class Day {
  List<Meal> meals;
  Nutrients nutrients;

  Day({
    required this.meals,
    required this.nutrients,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
        nutrients: Nutrients.fromJson(json["nutrients"]),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
        "nutrients": nutrients.toJson(),
      };
}

class Meal {
  int id;
  String image;
  String title;
  int readyInMinutes;
  int servings;
  String sourceUrl;

  Meal({
    required this.id,
    required this.image,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
      };
}

class Nutrients {
  double calories;
  double protein;
  double fat;
  double carbohydrates;

  Nutrients({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
  });

  factory Nutrients.fromJson(Map<String, dynamic> json) => Nutrients(
        calories: json["calories"].toDouble(),
        protein: json["protein"].toDouble(),
        fat: json["fat"].toDouble(),
        carbohydrates: json["carbohydrates"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "calories": calories,
        "protein": protein,
        "fat": fat,
        "carbohydrates": carbohydrates,
      };
}
