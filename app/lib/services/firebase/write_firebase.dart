import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../models/food_model.dart';

final currentUserID = FirebaseAuth.instance.currentUser!.uid;

Future<String?> uploadFoodPicToFirestorage(
    String userID, File photoFile) async {
  String? downloadURL;

  // create a unique ID for the photo
  String photoID = const Uuid().v4();

  // create a reference to the photo in firebase storage
  Reference photoRef = FirebaseStorage.instance
      .ref()
      .child('userFoodPictures')
      .child(userID)
      .child(photoID);

  // upload the photo to Firebase Storage
  UploadTask uploadTask = photoRef.putFile(photoFile);

  // wait for the upload to complete
  TaskSnapshot taskSnapshot = await uploadTask;

  // get the download URL for the photo
  downloadURL = await taskSnapshot.ref.getDownloadURL();

  // return the download URL for the photo
  return downloadURL;
}

Future<void> writeFoodScanResultsToFirestore(String userID, File foodPic,
    List<dynamic> foods, List<dynamic> nutrients, String processedImage) async {
  String? picURL = await uploadFoodPicToFirestorage(userID, foodPic);

  // Convert the List<FoodModel> to a List of Maps
  List<Map<String, dynamic>> foodDataList =
      foods.map((food) => foodModelToMap(food)).toList();

  await FirebaseFirestore.instance
      .collection('allResults')
      .doc(userID)
      .collection('userResults')
      .add(
    {
      'foodPicURL': picURL,
      'timestamp': Timestamp.now(),
      'processedImage': processedImage,
      'foods': foodDataList,
      'identifiedFoodNutrients': [
        {'name': 'Proteins', 'grams': nutrients[0]},
        {'name': 'Fats', 'grams': nutrients[1]},
        {'name': 'Carbohydrates', 'grams': nutrients[2]}
      ],
    },
  );
}
