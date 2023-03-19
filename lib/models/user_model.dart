import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userID;
  final String? givenName;
  final String? otherNames;
  final String? email;
  final String? birthDate;
  final String? gender;

  UserModel({
    this.userID,
    this.givenName,
    this.otherNames,
    this.email,
    this.birthDate,
    this.gender,
  });

  void addUserData(
    userID,
    givenName,
    otherNames,
    email,
    birthDate,
    gender,
  ) {
    final db = FirebaseFirestore.instance;
    db.collection("users").doc(userID).set({
      "userID": userID,
      "givenName": givenName,
      "otherNames": otherNames,
      "email": email,
      "birthDate": birthDate,
      "gender": gender
    });
  }
}
