import 'package:flutter/material.dart';
import 'package:get/get.dart';

void ocrFeatureInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('About TextSnap'),
        content: Text(
          'TextSnap uses OCR (Optical Character Recognition) to extract text from images. '
              'You can capture images using the camera or pick from the gallery, and the text will be recognized. '
              'You can also convert the recognized text to speech or translate it into different languages. '
              'This is useful for scanning documents, notes, signs, or any text-heavy material quickly.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}


void showTrackItFeatureInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('About TrackIt'),
        content: Text(
          'TrackIt helps you detect and track multiple objects in real-time using your device’s camera. '
              'It can recognize objects like people, animals, vehicles, and other items, and highlight them on the screen as you move the camera. '
              'This feature is useful for security monitoring, object counting, sports analysis, or educational purposes. '
              'You can interact with objects and get instant feedback as they appear in your view.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

