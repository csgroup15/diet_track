class FoodModel {
  String name;
  double confidence;

  FoodModel({required this.name, required this.confidence});

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      name: map['name'],
      confidence: map['confidence'],
    );
  }
}

Map<String, dynamic> foodModelToMap(FoodModel foodModel) {
  return {
    'name': foodModel.name,
    'confidence': foodModel.confidence,
  };
}
