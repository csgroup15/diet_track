import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_track/models/food_model.dart';

import 'nutrient_model.dart';

class ResultModel {
  String resultID, userID, foodPicURL, processedImage;
  Timestamp timestamp;
  List<FoodModel>? foods;
  final List<FoodNutrient>? identifiedFoodNutrients;

  ResultModel({
    required this.resultID,
    required this.userID,
    required this.processedImage,
    required this.foodPicURL,
    required this.timestamp,
    this.foods,
    this.identifiedFoodNutrients,
  });
}
