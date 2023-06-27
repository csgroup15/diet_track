import 'package:cloud_firestore/cloud_firestore.dart';

import 'nutrient_model.dart';

class ResultModel {
  String resultID, userID, foodPicURL;
  Timestamp timestamp;
  final List<FoodNutrient>? identifiedFoodNutrients;

  ResultModel({
    required this.resultID,
    required this.userID,
    required this.foodPicURL,
    required this.timestamp,
    this.identifiedFoodNutrients,
  });
}
