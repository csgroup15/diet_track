import 'dart:io';

import 'package:diet_track/models/nutrient_model.dart';
import 'package:flutter/foundation.dart';

import '../../config/constants.dart';
import '../../models/food_model.dart';
import '../../models/user_model.dart';
import '../../utils/formatter.dart';
import '../firebase/read_firebase.dart';
import 'food_model_hive.dart';
import 'nutrient_model_hive.dart';
import 'result_model_hive.dart';
import 'user_model_hive.dart';

Future<void> saveUserModelToHive(String currUserID) async {
  try {
    UserModel? userModelDataFromFirebase =
        await getUserModelFromFirebase(currUserID);

    UserModelHive userModelDataToHive = UserModelHive(
      userID: userModelDataFromFirebase!.userID,
      givenName: userModelDataFromFirebase.givenName,
      otherNames: userModelDataFromFirebase.otherNames,
      email: userModelDataFromFirebase.email,
    );

    if (userDataBox.isEmpty) {
      await userDataBox.add(userModelDataToHive); // Add the object to the box
    } else {
      await userDataBox.put(
          0, userModelDataToHive); // Update the object at index 0
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error saving user model to Hive: $e');
    }
  }
}

Future<String> storeFoodPicPathToHive(
    String foodPicURL, String resultID) async {
  Uint8List bytes =
      await downloadFoodPicFromFirebaseStorage(currentUserID, foodPicURL);
  File tempFile = await storeImageInTempDirectory(bytes, resultID);
  String imagePath = await storeImageInAppDirectory(tempFile, resultID);
  return imagePath;
}

Future<void> saveFoodScanResultsToHive(String currUserID) async {
  try {
    final existingResultsIDs =
        Set<String>.from(userResultsBox.keys.cast<String>());

    final resultsData = await getUserFoodScanResultsFromFirebase(currentUserID);

    for (final result in resultsData) {
      if (existingResultsIDs.contains(result.resultID)) {
        existingResultsIDs.remove(result.resultID);
        continue;
      }

      String? foodPicPathHive =
          await storeFoodPicPathToHive(result.foodPicURL, result.resultID);

      // Convert FoodModel list to FoodModelHive list
      final foodsHive = (result.foods as List<FoodModel>)
          .map((FoodModel food) => FoodModelHive(
                name: food.name,
                confidence: food.confidence,
              ))
          .toList();

      // Convert FoodNutrient list to FoodNutrientHive list
      final identifiedFoodNutrientsHive =
          (result.identifiedFoodNutrients as List<FoodNutrient>)
              .map((FoodNutrient foodNutrient) => FoodNutrientHive(
                    name: foodNutrient.name,
                    grams: foodNutrient.grams,
                  ))
              .toList();

      final resultModelHive = ResultModelHive(
        resultID: result.resultID,
        timestamp: formatTimestampToDatetime(result.timestamp),
        userID: result.userID,
        foodPicURL: foodPicPathHive,
        processedImage: result.processedImage,
        foods: foodsHive,
        identifiedFoodNutrients: identifiedFoodNutrientsHive,
      );

      await userResultsBox.put(result.resultID, resultModelHive);
      if (kDebugMode) {
        print('Saved result ${result.resultID} to Hive');
      }
    }

    for (final resultID in existingResultsIDs) {
      await userResultsBox.delete(resultID);
      if (kDebugMode) {
        print('Deleted result $resultID from Hive');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error saving user result to Hive: $e');
    }
  }
}
