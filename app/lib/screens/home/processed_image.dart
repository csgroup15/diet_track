String? getProcessedImageString(List<dynamic> segmentationResult) {
  for (var segment in segmentationResult) {
    if (segment.containsKey("processed_image")) {
      return segment["processed_image"];
    }
  }
  return null;
}
