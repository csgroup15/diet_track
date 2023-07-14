import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendImageForSegmentation(String imagePath) async {
  var apiUrl = 'https://777d-197-239-8-171.ngrok-free.app';

  try {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['ngrok-skip-browser-warning'] =
        '69420'; // Add the custom header
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(responseString);
      var classPercentages = jsonResponse['class_percentages'];

      return classPercentages;
    } else {
      throw Exception('Failed with status: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
