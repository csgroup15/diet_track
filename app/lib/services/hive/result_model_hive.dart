import 'package:hive/hive.dart';

import 'nutrient_model_hive.dart';
part 'result_model_hive.g.dart';

@HiveType(typeId: 2)
class ResultModelHive {
  @HiveField(0)
  String resultID;
  @HiveField(1)
  DateTime timestamp;
  @HiveField(2)
  String userID;
  @HiveField(3)
  String foodPicURL;
  @HiveField(4)
  List<String>? foods;
  @HiveField(5)
  final List<FoodNutrientHive>? identifiedFoodNutrients;

  ResultModelHive({
    required this.resultID,
    required this.timestamp,
    required this.userID,
    required this.foodPicURL,
    this.foods,
    this.identifiedFoodNutrients,
  });
}
