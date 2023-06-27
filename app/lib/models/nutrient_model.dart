class FoodNutrient {
  String name;
  double percentage;

  FoodNutrient({required this.name, required this.percentage});

  factory FoodNutrient.fromMap(Map<String, dynamic> map) {
    return FoodNutrient(
      name: map['name'],
      percentage: map['percentage'].toDouble(),
    );
  }
}
