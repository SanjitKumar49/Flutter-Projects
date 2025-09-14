import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app_ml_kit/app/controllers/scenesense_controller.dart';

class ScenesenseScreen extends StatefulWidget {
  const ScenesenseScreen({super.key});

  @override
  State<ScenesenseScreen> createState() => _ScenesenseScreenState();
}

class _ScenesenseScreenState extends State<ScenesenseScreen> {
  CameraController? cameraController;
  final controller = Get.put(ScenesenseController());

  @override
  void initState() {
    // TODO: implement initState
    initializeCamera();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    cameraController?.dispose();

    super.dispose();
  }
  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras[0], // back camera
          ResolutionPreset.medium,
          enableAudio: false,
        );

        await cameraController!.initialize();

        // Start image stream
        cameraController!.startImageStream(controller.processCameraImage);
        setState(() {

        });
      }
    } catch (e) {
      log('Camera initialization error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'SceneSense',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              // You can implement showSceneSenseInfo(context) if needed
              Get.defaultDialog(
                title: "About SceneSense",
                content: Text("Detect and label objects live using ML Kit."),
                confirm: TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Close"),
                ),
              );
            },
          ),
        ],
      ),
      body:
      // Obx(()
      // {
      //  if (controller.cameraController == null || !controller.cameraController!.value.isInitialized) {
        //  return Center(child: CircularProgressIndicator());
        //}

        //return
        Stack(
          children: [
            CameraPreview(cameraController!),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(12),
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.labels.map((label) {
                    return Text(
                      "${label.label} (${(label.confidence * 100).toStringAsFixed(2)}%)",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        )
      // }
      // ),
    );
  }
}
