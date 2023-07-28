import 'package:hive/hive.dart';
part 'food_model_hive.g.dart';

@HiveType(typeId: 4)
class FoodModelHive {
  @HiveField(0)
  String name;
  @HiveField(1)
  double confidence;

  FoodModelHive({
    required this.name,
    required this.confidence,
  });

  factory FoodModelHive.fromJson(Map<String, dynamic> json) {
    return FoodModelHive(
      name: json['name'],
      confidence: json['confidence'],
    );
  }

  factory FoodModelHive.fromMap(Map<String, dynamic> map) {
    return FoodModelHive(
      name: map['name'],
      confidence: map['confidence'],
    );
  }
}
