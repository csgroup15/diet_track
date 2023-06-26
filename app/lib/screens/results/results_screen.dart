import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/result_model.dart';
import '../../services/firebase/read_firebase.dart';
import '../../services/hive/result_model_hive.dart';
import '../../utils/formatter.dart';
import 'result_detail.dart';

final userID = FirebaseAuth.instance.currentUser!.uid;

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/resultsscreen';

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final Future<List<ResultModel>> resultsFuture =
      getUserFoodScanResultsFromFirebase(userID);

  late final Box resultsBox;

  @override
  void initState() {
    super.initState();
    resultsBox = Hive.box('results');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                'Recent',
                style: TextStyle(fontSize: 31.0, fontWeight: FontWeight.w300),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                'Results',
                style: TextStyle(fontSize: 31.0, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ValueListenableBuilder(
                  valueListenable: resultsBox.listenable(),
                  builder: (context, Box box, widget) {
                    if (box.isEmpty) {
                      return FutureBuilder<List<ResultModel>>(
                        future: resultsFuture,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ResultModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            final results = snapshot.data!;
                            if (results.isEmpty) {
                              return const Center(
                                child: Text('No Results Yet'),
                              );
                            } else {
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                ),
                                itemCount: results.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final result = results[index];
                                  return GestureDetector(
                                      onTap: () {
                                        // Navigate to a details page for this result
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    result.foodPicURL),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  result.resultID,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                                },
                              );
                            }
                          } else {
                            return Container(); // Placeholder for empty state
                          }
                        },
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemCount: box.length,
                        itemBuilder: (BuildContext context, int index) {
                          var currentBox = box;
                          ResultModelHive resultHive = currentBox.getAt(index)!;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultDetailScreen(
                                          resultHive: resultHive,
                                        )),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(
                                    File(resultHive.foodPicURL),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    formatResultTimeFromDateTimeToString(
                                        resultHive.timestamp),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
