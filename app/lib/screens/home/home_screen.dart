import 'dart:io';

import 'package:diet_track/services/hive/nutrient_model_hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../config/constants.dart';
import '../../services/api/model_service.dart';
import '../../services/hive/read_hive.dart';
import '../../services/hive/result_model_hive.dart';
import '../../utils/image.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';

final currentUserID = FirebaseAuth.instance.currentUser!.uid;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Box resultsBox;
  bool _isLoading = false;
  Map<String, dynamic>? _segmentationResult;

  @override
  void initState() {
    super.initState();
    resultsBox = Hive.box('results');
  }

  Future<void> _segmentImage(String imagePath) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await sendImageForSegmentation(imagePath);
      if (kDebugMode) {
        print('Results on the API test Page: $result');
      }
      setState(() {
        _segmentationResult = result;
      });
    } catch (e) {
      // Handle errors
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 25,
                ),
                Text(
                  'Last meal results',
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.5,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: getCurrentTheme(context) == 'dark'
                        ? Colors.grey
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                height: 400,
                                child: ValueListenableBuilder(
                                  valueListenable: resultsBox.listenable(),
                                  builder: (context, box, widget) {
                                    final ResultModelHive? latestResult =
                                        readLatestUserResultFromHive();
                                    final List<FoodNutrientHive>? nutrients =
                                        latestResult
                                            ?.identifiedFoodNutrients; // get the latest result from the box
                                    return latestResult != null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: SizedBox(
                                                    width: 350,
                                                    height: 200,
                                                    child: Image.file(
                                                      File(latestResult
                                                          .foodPicURL),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Nutrients',
                                                        style: TextStyle(
                                                          color: getCurrentTheme(
                                                                      context) ==
                                                                  'dark'
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 21,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Center(
                                                        child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          nutrients!.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        FoodNutrientHive
                                                            nutrient =
                                                            nutrients[index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 5, 0, 0),
                                                          child: Text(
                                                            '${nutrient.name}: ${nutrient.percentage.toStringAsFixed(1)}%',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : const Center(
                                            child: Text(
                                                'Scan foods to see results.'),
                                          );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 55,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: _isLoading
                  ? const Text('No results loading now')
                  : _segmentationResult != null
                      ? _buildResultWidget(_segmentationResult!)
                      : const Center(
                          child: Text('No result'),
                        ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 25,
                ),
                Text(
                  'Discover',
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.5,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 25,
                ),
                Text(
                  'What\'s in your food',
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            _isLoading
                ? Container(
                    height: 40,
                    width: 250,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: kWhiteColor,
                      ),
                    ))
                : GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        backgroundColor: kPrimaryColor,
                        Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.browse_gallery),
                              title: const Text(
                                'From Gallery',
                              ),
                              onTap: () async {
                                Get.back();
                                File? photo = await pickImageFromPhoneGallery();
                                if (!mounted) return;
                                if (photo != null) {
                                  await _segmentImage(photo.path);
                                }
                                // Get.to(() => ApiTest(imagePath: photo!.path));
                                // getFoodPicSegments(
                                //     File(readClassModelPath()), photo!);
                                // showUploadDialog(context);
                                // await writeFoodScanResultsToFirestore(
                                //     currentUserID, photo!);
                                // await saveFoodScanResultsToHive(currentUserID);
                                // if (!mounted) return;
                                // hideUploadDialog(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text('From Camera'),
                              onTap: () async {
                                Get.back();
                                // File? photo = await pickImageFromPhoneCamera();
                                if (!mounted) return;
                                // getFoodPicSegments(
                                //     File(readClassModelPath()), photo!);
                                // showUploadDialog(context);
                                // await writeFoodScanResultsToFirestore(
                                //     currentUserID, photo!);
                                // await saveFoodScanResultsToHive(currentUserID);
                                // if (!mounted) return;
                                // hideUploadDialog(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 250,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.picture_in_picture_alt,
                            color: kWhiteColor,
                          ),
                          SizedBox(width: 17),
                          Text(
                            'Choose Food Image',
                            style: TextStyle(fontSize: 17, color: kWhiteColor),
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultWidget(Map<String, dynamic>? res) {
    return Center(
      child: Text(
        'Segmentation Result: $res',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
