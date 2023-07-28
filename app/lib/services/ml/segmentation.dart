import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> sendImageForSegmentation(String imagePath) async {
  var apiUrl = 'https://68e4-197-239-9-227.ngrok-free.app';

  try {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['ngrok-skip-browser-warning'] = '69420';
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(responseString);
      var segResult = jsonResponse['segmentation_result'];
      return segResult;
    } else {
      throw Exception('Failed with status: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
