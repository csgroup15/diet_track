import 'package:cloud_firestore/cloud_firestore.dart';

class ResultModel {
  String resultID, userID, foodPicURL;
  Timestamp timestamp;
  final List<String>? identifiedFoodIDs;

  ResultModel(
      {required this.resultID,
      required this.userID,
      required this.foodPicURL,
      required this.timestamp,
      this.identifiedFoodIDs});
}
