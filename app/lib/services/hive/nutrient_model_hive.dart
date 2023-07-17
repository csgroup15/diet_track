import 'package:hive/hive.dart';
part 'nutrient_model_hive.g.dart';

@HiveType(typeId: 3)
class FoodNutrientHive {
  @HiveField(0)
  String name;
  @HiveField(1)
  double grams;

  FoodNutrientHive({
    required this.name,
    required this.grams,
  });

  factory FoodNutrientHive.fromJson(Map<String, dynamic> json) {
    return FoodNutrientHive(
      name: json['name'],
      grams: json['grams'],
    );
  }

  factory FoodNutrientHive.fromMap(Map<String, dynamic> map) {
    return FoodNutrientHive(
      name: map['name'],
      grams: map['grams'],
    );
  }
}
