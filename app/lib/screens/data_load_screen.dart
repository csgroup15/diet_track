import 'package:diet_track/main.dart';
import 'package:diet_track/screens/landing_page.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../services/hive/write_hive.dart';

class DataLoadingScreen extends StatefulWidget {
  const DataLoadingScreen({Key? key}) : super(key: key);

  @override
  DataLoadingScreenState createState() => DataLoadingScreenState();
}

class DataLoadingScreenState extends State<DataLoadingScreen> {
  bool _isLoading = true;
  double _loadingProgress = 0;
  bool _isDataLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (userDataBox.isEmpty) {
      if (userDataBox.isEmpty) {
        setState(() {
          _isDataLoading = true;
        });
        await _saveUserData();

        setState(() {
          _isDataLoading = false;
        });
      }
    }

    setState(() {
      _isLoading = false;
      _isDataLoading = false;
    });
  }

  Future<void> _saveUserData() async {
    const total = 100;
    var loaded = 0;

    for (var i = 0; i < total; i++) {
      // simulate loading data
      await Future.delayed(const Duration(milliseconds: 50));
      loaded++;
      setState(() {
        _loadingProgress = loaded / total;
      });
    }

    await saveUserModelToHive(currUserID);
    await saveFoodScanResultsToHive(currUserID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isDataLoading) ...[
                    CircularProgressIndicator(
                      value: _loadingProgress,
                      color: kPrimaryColor,
                      strokeWidth: 4,
                    ),
                    const SizedBox(height: 16),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Let\'s prepare the app... ${(_loadingProgress * 100).toStringAsFixed(0)}%',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ))
                  ],
                ],
              )
            : const LandingPage(),
      ),
    );
  }
}
