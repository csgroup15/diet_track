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
  Map<String, dynamic>? _segmentationResult;

  @override
  void initState() {
    super.initState();
    _segmentImage();
  }

  Future<void> _segmentImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await sendImageForSegmentation(widget.imagePath);
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
        appBar: AppBar(
          title: const Text('Image Segementation'),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _segmentationResult != null
                ? _buildResultWidget(_segmentationResult!)
                : const Center(
                    child: Text('No result'),
                  ));
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
