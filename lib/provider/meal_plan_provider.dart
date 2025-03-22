import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metafit/utils/nutrition_utils/json_parsing/meal_planner_json_parsing.dart';

class MealPlanProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<MealPlanner> _mealPlans = [];

  List<MealPlanner> get mealPlans => _mealPlans;

  MealPlanner? getMealPlanByName(String mealName) {
    return _mealPlans.firstWhere(
      (plan) => plan.mealPlanName == mealName,
      orElse: () => MealPlanner(mealPlanName: "", meals: [], nutrients: null),
    );
  }

  Future<void> fetchMealPlans() async {
    String userId = _auth.currentUser?.uid ?? "";
    if (userId.isEmpty) {
      // ❌ No user logged in. Skipping meal plan fetch.
      return;
    }

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('mealPlans')
          .get();

      if (snapshot.docs.isEmpty) {
        // 📭 No meal plans found in Firestore.
      }

      _mealPlans = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data["mealPlanName"] = doc.id; // Ensure document ID is used
        return MealPlanner.fromJson(data);
      }).toList();

      notifyListeners(); // Refresh UI
    } catch (e) {
      // Error fetching meal plans
    }
  }

  Future<void> addMealPlan(String mealName, MealPlanner mealPlan) async {
    String userId = _auth.currentUser?.uid ?? "";
    if (userId.isEmpty) return;

    try {
      Map<String, dynamic> mealPlanData = mealPlan.toJson();
      mealPlanData["mealPlanName"] = mealName; // Store meal name explicitly

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('mealPlans')
          .doc(mealName)
          .set(mealPlanData);

      _mealPlans.add(
          MealPlanner.fromJson(mealPlanData)); // Ensure local list is updated
      notifyListeners();
    } catch (e) {
      // "Error adding meal plan
    }
  }

  // Remove a specific meal plan
  Future<void> removeMealPlan(String planName) async {
    String userId = _auth.currentUser?.uid ?? "";
    if (userId.isEmpty) return;

    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('mealPlans')
          .doc(planName)
          .delete();

      _mealPlans.removeWhere((plan) => plan.mealPlanName == planName);
      notifyListeners();
    } catch (e) {
      // Error deleting meal plan
    }
  }

  // Remove all meal plans for the user
  Future<void> removeAllPlans() async {
    String userId = _auth.currentUser?.uid ?? "";
    if (userId.isEmpty) return;

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('mealPlans')
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      _mealPlans.clear();
      notifyListeners();
    } catch (e) {
      // Error deleting all meal plans
    }
  }
}
