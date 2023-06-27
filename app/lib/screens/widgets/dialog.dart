import 'package:flutter/material.dart';

import '../../config/constants.dart';

showUploadDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: kBottomSheetContainer,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: kWhiteColor,
              ),
              SizedBox(height: 16.0),
              Text('Uploading image...'),
            ],
          ),
        ),
      );
    },
  );
}

hideUploadDialog(BuildContext context) {
  Navigator.of(context).pop();
}
