import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

Future<bool> imageContainsFood(final InputImage inputImage) async {
  final ImageLabelerOptions options =
      ImageLabelerOptions(confidenceThreshold: 0.5);
  final imageLabeler = ImageLabeler(options: options);

  final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

  for (ImageLabel label in labels) {
    final String text = label.label;
    final double confidence = label.confidence;
    if (text == 'Food' && confidence > 0.6) {
      imageLabeler.close();
      return true;
    }
  }

  imageLabeler.close();
  return false;
}
