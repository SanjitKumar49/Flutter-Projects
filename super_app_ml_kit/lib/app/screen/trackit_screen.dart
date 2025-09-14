import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/trackit_controller.dart';

class TrackitScreen extends StatelessWidget {
  const TrackitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrackitController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('TrackIt', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showTrackItFeatureInfo(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() {
              if (controller.pickedImage.value != null) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    controller.pickedImage.value!,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text('No Image Selected', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ),
                );
              }
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: controller.captureImageFromCamera,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Camera'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: controller.pickImageFromGallery,
                  icon: Icon(Icons.photo_library),
                  label: Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.detectedObjects.isEmpty) {
                  return Center(child: Text("No objects detected."));
                }
                return ListView.builder(
                  itemCount: controller.detectedObjects.length,
                  itemBuilder: (context, index) {
                    final obj = controller.detectedObjects[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(Icons.adjust),
                        title: Text("Object ID: ${obj.trackingId ?? 'N/A'}"),
                        subtitle: Text(
                            "Labels: ${obj.labels.map((e) => e.text).join(', ')}"),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

void showTrackItFeatureInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('About TrackIt'),
        content: Text(
          'TrackIt helps you detect and track objects like people, vehicles, animals, etc. '
              'You can pick an image from your gallery or capture one using the camera. '
              'The app will process the image and highlight the objects it finds. '
              'This is useful for security, inventory management, or educational purposes.',
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
