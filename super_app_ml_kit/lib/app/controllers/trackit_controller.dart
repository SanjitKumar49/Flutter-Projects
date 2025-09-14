import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:permission_handler/permission_handler.dart';

/*
class TrackitController extends GetxController {
  CameraController? cameraController;
  late ObjectDetector objectDetector;
  var detectedObjects = <DetectedObject>[].obs;
  var isBusy = false.obs;
  var isCameraInitialized = false.obs;
  var cameraFeedSize = const Size(0, 0).obs;
  var cameraLensDirection = CameraLensDirection.back.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDetector();
    initializeCamera();
  }

  void initializeDetector() {
    objectDetector = ObjectDetector(
      options: ObjectDetectorOptions(
        classifyObjects: true,
        multipleObjects: true,
        mode: DetectionMode.stream,
      ),
    );
  }

  Future<void> initializeCamera() async {
    try {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        Get.snackbar('Permission Denied', 'Please allow camera access');
        return;
      }

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        Get.snackbar('Camera Error', 'No camera found');
        return;
      }

      // Select back camera by default
      final camera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await cameraController!.initialize();
      cameraLensDirection.value = camera.lensDirection;
      cameraFeedSize.value = Size(
        cameraController!.value.previewSize!.width,
        cameraController!.value.previewSize!.height,
      );

      isCameraInitialized.value = true;
      cameraController!.startImageStream(processCameraImage);
      update();
    } catch (e) {
      print('Error initializing camera: $e');
      Get.snackbar('Error', 'Failed to initialize camera: $e');
    }
  }

  Future<void> processCameraImage(CameraImage image) async {
    if (isBusy.value) return;
    isBusy.value = true;

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

      final camera = cameraController!.description;
      final imageRotation =
          InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
              InputImageRotation.rotation0deg;

      final inputImageFormat =
          InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;

      final planeData = image.planes.map(
            (plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList();

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        inputImageData: InputImageData(
          size: imageSize,
          imageRotation: imageRotation,
          inputImageFormat: inputImageFormat,
          planeData: planeData,
        ),
      );

      final objects = await objectDetector.processImage(inputImage);
      detectedObjects.value = objects;
    } catch (e) {
      print('Error in processCameraImage: $e');
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> toggleCamera() async {
    if (cameraController == null) return;

    final cameras = await availableCameras();
    if (cameras.length < 2) return;

    final newLensDirection = cameraLensDirection.value == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    final newCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == newLensDirection,
      orElse: () => cameras.firstWhere(
            (camera) => camera.lensDirection != cameraLensDirection.value,
      ),
    );

    await cameraController!.dispose();

    cameraController = CameraController(
      newCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await cameraController!.initialize();
    cameraLensDirection.value = newCamera.lensDirection;
    cameraFeedSize.value = Size(
      cameraController!.value.previewSize!.width,
      cameraController!.value.previewSize!.height,
    );

    cameraController!.startImageStream(processCameraImage);
    update();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    objectDetector.close();
    super.onClose();
  }
}
*/

class TrackitController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var pickedImage = Rxn<File>();
  var detectedObjects = <DetectedObject>[].obs;

  late ObjectDetector objectDetector;

  @override
  void onInit() {
    super.onInit();
    objectDetector = ObjectDetector(
      options: ObjectDetectorOptions(
        classifyObjects: true,
        multipleObjects: true,
        mode: DetectionMode.single, // Since it's from image file
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
   // final status = await Permission.photos.request();
   //  if (!status.isGranted) {
   //    Get.snackbar('Permission Denied', 'Please allow gallery access');
   //    return;
   //  }

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
      await processImage(image.path);
    }
  }

  Future<void> captureImageFromCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      Get.snackbar('Permission Denied', 'Please allow camera access');
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImage.value = File(image.path);
      await processImage(image.path);
    }
  }

  Future<void> processImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final objects = await objectDetector.processImage(inputImage);
    detectedObjects.value = objects;
  }

  @override
  void onClose() {
    objectDetector.close();
    super.onClose();
  }
}
