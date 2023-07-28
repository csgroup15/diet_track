import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../services/hive/nutrient_model_hive.dart';
import '../../services/hive/result_model_hive.dart';
import '../../utils/formatter.dart';
import 'pm_screen.dart';

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
    final foods = widget.resultHive.foods;
    final List<FoodNutrientHive>? nutrients =
        widget.resultHive.identifiedFoodNutrients;

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
              height: screenHeight * 0.513,
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
                      'Check Time: ${formatResultTimeFromDateTimeToString(widget.resultHive.timestamp)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    )),
                    SizedBox(height: screenHeight * 0.0223),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Foods',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.resultHive.foods!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final food = foods![index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Text(
                                food.name,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.0423),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nutrients',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          widget.resultHive.identifiedFoodNutrients!.length,
                      itemBuilder: (BuildContext context, int index) {
                        FoodNutrientHive nutrient = nutrients![index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            '${nutrient.name}: ${nutrient.grams.toStringAsFixed(1)} grams',
                            style: const TextStyle(
                                fontSize: 17, color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Centered rectangular button in green color
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PMScreen(
                      resultHive: widget.resultHive,
                    )),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor, // Set the text color to white.
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'View Metrics',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
