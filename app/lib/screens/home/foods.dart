import 'dart:convert';

import '../../models/food_model.dart';

List<FoodModel> getFoodNamesWithConfidence(List<dynamic> segmentationResult) {
  String jsonData = '''
  [
    {"class_label":"805002","food_name":"Matooke","energy_kcal":"1.17136659436009","protein_g":"0.00867678958785249","carbohydrates_g":"0.31236442516269","fats_g":"0.00216919739696312"},
    {"class_label":"830088","food_name":"matooke","energy_kcal":"1.04895104895105","protein_g":"0.00959692898272553","carbohydrates_g":"0.247600767754319","fats_g":"0.00233100233100233"},
    {"class_label":"806130","food_name":"Dry beans","energy_kcal":"1.26773888363292","protein_g":"0.086472602739726","carbohydrates_g":"0.227882037533512","fats_g":"0.0051413881748072"},
    {"class_label":"806122","food_name":"Fresh beans","energy_kcal":"0.800438596491228","protein_g":"0.0559210526315789","carbohydrates_g":"0.143640350877193","fats_g":"0.00219298245614035"},
    {"class_label":"814024","food_name":"Deep fried fish","energy_kcal":"1.17647058823529","protein_g":"0.245098039215686","carbohydrates_g":"0","fats_g":"0.00980392156862745"},
    {"class_label":"814021","food_name":"Fresh fish","energy_kcal":"0.898876404494382","protein_g":"0.194756554307116","carbohydrates_g":"0","fats_g":"0.00749063670411985"},
    {"class_label":"814025","food_name":"Roasted fish","energy_kcal":"1.14583333333333","protein_g":"0.25","carbohydrates_g":"0","fats_g":"0.0104166666666667"},
    {"class_label":"808186","food_name":"Kinyebwa","energy_kcal":"3.37553410349739","protein_g":"0.231087094723458","carbohydrates_g":"0.598441073793186","fats_g":"0.00989148180159416"},
    {"class_label":"801041","food_name":"Posho","energy_kcal":"3.6899410271505","protein_g":"0.0725212464589235","carbohydrates_g":"0.79149299264892","fats_g":"0.017894867928892"},
    {"class_label":"830022","food_name":"Ndiizi","energy_kcal":"0.546875","protein_g":"0","carbohydrates_g":"0.140625","fats_g":"0"},
    {"class_label":"30001","food_name":"Bogoya","energy_kcal":"0.888030888030888","protein_g":"0.0108785941231698","carbohydrates_g":"0.228281853281853","fats_g":"0.00337837837837838"},
    {"class_label":"30091","food_name":"Jack fruit","energy_kcal":"0.939836240655037","protein_g":"0.0147128618889416","carbohydrates_g":"0.240081383519837","fats_g":"0.00284900284900285"},
    {"class_label":"1206","food_name":"Brown rice","energy_kcal":"1.75955880229839","protein_g":"0.0359388444547108","carbohydrates_g":"0.370943319954956","fats_g":"0.0129142725146537"},
    {"class_label":"1203","food_name":"White rice","energy_kcal":"1.75991718426501","protein_g":"0.0319952606635071","carbohydrates_g":"0.387985573979702","fats_g":"0.00300440076101558"},
    {"class_label":"3001","food_name":"White sweet potato","energy_kcal":"1.07578980959472","protein_g":"0.0194107009892565","carbohydrates_g":"0.251999787256675","fats_g":"0.000673332624188916"},
    {"class_label":"4006","food_name":"Yellow sweet potato","energy_kcal":"1.13888034450938","protein_g":"0.0207715133531157","carbohydrates_g":"0.266487213997308","fats_g":"0.000615195324515534"}
  ]
  ''';
  double? getConfidenceByLabel(
      List<dynamic> segmentationResult, String classLabel) {
    for (var segment in segmentationResult) {
      if (segment.containsKey("label") &&
          segment["label"].toString() == classLabel) {
        return segment["confidence_score"];
      }
    }
    return null;
  }

  List<dynamic> foodData = json.decode(jsonData);
  List<FoodModel> foodModels = [];

  for (var food in foodData) {
    String classLabel = food["class_label"];
    double? confid = getConfidenceByLabel(segmentationResult, classLabel);

    if (confid != null) {
      String foodName = food["food_name"];
      double confidence = confid;

      FoodModel foodModel = FoodModel(name: foodName, confidence: confidence);
      foodModels.add(foodModel);
    }
  }
  return foodModels;
}
