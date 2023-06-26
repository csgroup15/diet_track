import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/result_model.dart';
import '../../models/user_model.dart';

final currentUserID = FirebaseAuth.instance.currentUser!.uid;

Future<UserModel?> getUserModelFromFirebase(String userID) async {
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot userDoc = await usersRef.doc(userID).get();
  if (userDoc.exists) {
    UserModel user = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    return user;
  } else {
    return null;
  }
}

Future<List<ResultModel>> getUserFoodScanResultsFromFirebase(
    String currentUserID) async {
  final resultsQuerySnapshot = await FirebaseFirestore.instance
      .collection('allResults')
      .doc(currentUserID)
      .collection('userResults')
      .get();
  final resultsDocs = resultsQuerySnapshot.docs;
  final results = resultsDocs.map((resultDoc) {
    final data = resultDoc.data();
    final resultID = resultDoc.id;
    final foodPicURL = data['foodPicURL'] as String;
    final timestamp = data['timestamp'] as Timestamp;
    final identifiedFoodIDs =
        List<String>.from(data['identifiedFoodIDs'] ?? []);
    return ResultModel(
      resultID: resultID,
      foodPicURL: foodPicURL,
      timestamp: timestamp,
      identifiedFoodIDs: identifiedFoodIDs,
      userID: currentUserID,
    );
  }).toList();
  return results;
}

Future<Uint8List> downloadFoodPicFromFirebaseStorage(
    String currUserID, String foodImageURL) async {
  var httpClient = HttpClient();
  var request = await httpClient.getUrl(Uri.parse(foodImageURL));
  var response = await request.close();
  Uint8List bytes = await consolidateHttpClientResponseBytes(response);

  return bytes;
}

Future<File> storeImageInTempDirectory(
    Uint8List bytes, String imageName) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('$tempPath/$imageName.jpg');
  await file.writeAsBytes(bytes);

  return file;
}

Future<String> storeImageInAppDirectory(File tempFile, String imageName) async {
  Directory appDir = await getApplicationDocumentsDirectory();
  String appPath = appDir.path;
  File newFile = await tempFile.copy('$appPath/$imageName.jpg');

  return newFile.path;
}
