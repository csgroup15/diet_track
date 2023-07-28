import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../services/hive/result_model_hive.dart';

final userID = FirebaseAuth.instance.currentUser!.uid;

class PMScreen extends StatefulWidget {
  const PMScreen({
    Key? key,
    required this.resultHive,
  }) : super(key: key);

  final ResultModelHive resultHive;

  @override
  State<PMScreen> createState() => _PMScreenState();
}

class _PMScreenState extends State<PMScreen> {
  @override
  Widget build(BuildContext context) {
    final foods = widget.resultHive.foods;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Metrics'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        // systemOverlayStyle:
        //     const SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.memory(
                  base64Decode(widget.resultHive.processedImage!),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 200, // Adjust the height as needed
                  child: DataTable(
                    // Adjust the row height as needed
                    headingRowHeight:
                        50, // Adjust the heading row height as needed
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Food',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Confidence',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    rows: foods!
                        .map(
                          (food) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  food.name,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${food.confidence}',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Centered rectangular button in green color
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor, // Set the text color to white.
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Send Feedback',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
