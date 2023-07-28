import 'package:diet_track/services/hive/food_model_hive.dart';
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
  String? processedImage;
  @HiveField(5)
  List<FoodModelHive>? foods;
  @HiveField(6)
  final List<FoodNutrientHive>? identifiedFoodNutrients;

  ResultModelHive({
    required this.resultID,
    required this.timestamp,
    required this.userID,
    required this.foodPicURL,
    required this.processedImage,
    this.foods,
    this.identifiedFoodNutrients,
  });
}
