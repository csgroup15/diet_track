import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../services/api/model_api.dart';

class ApiTest extends StatefulWidget {
  final String imagePath;

  const ApiTest({super.key, required this.imagePath});

  @override
  ApiTestState createState() => ApiTestState();
}

class ApiTestState extends State<ApiTest> {
  bool _isLoading = false;
  String? _predictionResult;

  @override
  void initState() {
    super.initState();
    _predictImage();
  }

  Future<void> _predictImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await sendImageForPrediction(widget.imagePath);
      if (kDebugMode) {
        print(result);
      }
      setState(() {
        _predictionResult = result;
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
        appBar: AppBar(
          title: const Text('Image Prediction'),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _buildResultWidget(_predictionResult!));
  }

  Widget _buildResultWidget(String res) {
    return Center(
      child: Text(
        'Result: $res',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
