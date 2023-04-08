import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userID;
  final String givenName;
  final String otherNames;
  final String email;

  UserModel({
    required this.userID,
    required this.givenName,
    required this.otherNames,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'givenName': givenName,
      'otherNames': otherNames,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userID: data['userID'],
      givenName: data['givenName'],
      otherNames: data['otherNames'],
      email: data['email'],
    );
  }

  void addUserData(UserModel user) {
    final db = FirebaseFirestore.instance;
    db.collection("users").doc(userID).set({
      "userID": user.userID,
      "givenName": user.givenName,
      "otherNames": user.otherNames,
      "email": user.email,
    });
  }
}
