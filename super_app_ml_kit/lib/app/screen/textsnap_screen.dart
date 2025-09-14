import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:super_app_ml_kit/app/util/constant.dart';
import '../controllers/textsnap_controller.dart';

class TextsnapScreen extends StatelessWidget {
  final TextSnapController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('TextSnap', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline,color: Colors.white,),
            onPressed: () {
              ocrFeatureInfo(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              if (controller.pickedImage.value != null) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(6),
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
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text('No Image Selected',
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ),
                );
              }
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeatureButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  onTap: controller.captureImage,
                ),
                FeatureButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  onTap: controller.pickImage,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      controller.recognizedText.value,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeatureButton(
                  icon: Icons.volume_up,
                  label: 'Text to Sound',
                  colors: [Colors.orange, Colors.deepOrangeAccent],
                  onTap: () => showTTSOptions(context),
                ),
                FeatureButton(
                  icon: Icons.translate,
                  label: 'Translate',
                  colors: [Colors.teal, Colors.greenAccent],
                  onTap: () => showTranslationDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void showTTSOptions(BuildContext context) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: () => controller.speak(),
            icon: Icon(Icons.play_arrow, color: Colors.white),
            label: Text('Start',style: TextStyle(color: Colors.white),),
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () => controller.pause(),
            icon: Icon(Icons.pause, color: Colors.white),
            label: Text('Pause'),
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () => controller.resume(),
            icon: Icon(Icons.play_arrow, color: Colors.white),
            label: Text('Resume'),
          ),
        ],
      ),
    ));
  }

  void showTranslationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Choose Language'),
          content: Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: () async {
                  final result = await controller.translate('es');
                  Get.back();
                  showTranslationResult(context, result);
                },
                child: Text('Spanish'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () async {
                  final result = await controller.translate('fr');
                  Get.back();
                  showTranslationResult(context, result);
                },
                child: Text('French'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  final result = await controller.translate('hi');
                  Get.back();
                  showTranslationResult(context, result);
                },
                child: Text('Hindi'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showTranslationResult(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Translation Result'),
          content: Text(result),
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
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Color> colors;
  final VoidCallback onTap;

  const FeatureButton({
    super.key,
    required this.icon,
    required this.label,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 140,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4))
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 8),
            Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
