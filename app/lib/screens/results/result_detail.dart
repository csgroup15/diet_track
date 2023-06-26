import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../services/hive/result_model_hive.dart';

final userID = FirebaseAuth.instance.currentUser!.uid;

class ResultDetailScreen extends StatefulWidget {
  const ResultDetailScreen({
    Key? key,
    required this.resultHive,
  }) : super(key: key);

  final ResultModelHive resultHive;
  @override
  State<ResultDetailScreen> createState() => _ResultDetailScreenState();
}

class _ResultDetailScreenState extends State<ResultDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: screenHeight * 0.3,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    File(widget.resultHive.foodPicURL),
                    scale: 1,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.3,
            child: Container(
              color: kLightGreyContainer,
            ),
          ),
          Positioned(
              bottom: screenHeight * 0.13,
              left: screenWidth * 0.052,
              right: screenWidth * 0.052,
              child: Container(
                height: screenHeight * 0.413,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kWhiteSmokeColor),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.0308,
                      ),
                      Center(
                          child: Text(
                        widget.resultHive.resultID,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      )),
                      SizedBox(height: screenHeight * 0.0123),
                      Center(
                          child: Text(
                        widget.resultHive.resultID,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 117, 112, 112),
                            fontSize: 17),
                      )),
                      SizedBox(height: screenHeight * 0.0423),
                      Row(
                        children: [
                          const Icon(Icons.food_bank),
                          const SizedBox(width: 10),
                          Text(widget.resultHive.resultID)
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
