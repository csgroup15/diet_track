class FoodNutrient {
  String name;
  double grams;

  FoodNutrient({required this.name, required this.grams});

  factory FoodNutrient.fromMap(Map<String, dynamic> map) {
    return FoodNutrient(
      name: map['name'],
      grams: map['grams'],
    );
  }
}
