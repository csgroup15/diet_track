import 'package:hive/hive.dart';
part 'nutrient_model_hive.g.dart';

@HiveType(typeId: 3)
class FoodNutrientHive {
  @HiveField(0)
  String name;
  @HiveField(1)
  double percentage;

  FoodNutrientHive({
    required this.name,
    required this.percentage,
  });

  factory FoodNutrientHive.fromJson(Map<String, dynamic> json) {
    return FoodNutrientHive(
      name: json['name'],
      percentage: json['percentage'].toDouble(),
    );
  }

  factory FoodNutrientHive.fromMap(Map<String, dynamic> map) {
    return FoodNutrientHive(
      name: map['name'],
      percentage: map['percentage'].toDouble(),
    );
  }
}
