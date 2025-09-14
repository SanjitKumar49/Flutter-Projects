import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app_ml_kit/app/controllers/camera_controller.dart';
// import '../controllers/camera_controller.dart' hide CameraController;

class MyCameraViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyCameraController>();

    return Scaffold(
      body: Obx(() {
        if (!controller.cameraController.value.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            CameraPreview(controller.cameraController),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: controller.detectedObjects.map((obj) {
                    return Text(
                      obj,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
