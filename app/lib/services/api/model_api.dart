import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Future<String> sendImageForPrediction(String imgPath) async {
  try {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imgPath),
    });

    Response response = await Dio().post(
      'https://diet-track-app.onrender.com/predict',
      data: formData,
    );

    // Parse the JSON response
    Map<String, dynamic> data = response.data;
    String pokemonName = data['pokemon'];

    return pokemonName;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return 'Image not recognized';
  }
}
