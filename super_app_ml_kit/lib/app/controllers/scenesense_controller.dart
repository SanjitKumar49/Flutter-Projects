import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart' hide InputImageRotation, InputImageFormat, InputImage;
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:satya_textocr/src_path/vision/vision.dart' hide InputImageRotation, InputImageFormat, InputImage, ImageLabeler, ImageLabel, ImageLabelerOptions;

import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class ScenesenseController extends GetxController {
  RxList<ImageLabel> labels = <ImageLabel>[].obs;
  late ImageLabeler imageLabeler;

  @override
  void onInit() {
    super.onInit();
    // initializeCamera();
    initializeImageLabeler();
  }

  void initializeImageLabeler() {
    final options = ImageLabelerOptions(confidenceThreshold: 0.5);
    imageLabeler = ImageLabeler(options: options);
  }


  void processCameraImage(CameraImage image) async {
    try {
      final inputImage = getInputImageFromCameraImage(image);

      if (inputImage == null) return;

      final result = await imageLabeler.processImage(inputImage);

      labels.value = result;
    } catch (e) {
      log('Image labeling error: $e');
    }
  }

  InputImage? getInputImageFromCameraImage(CameraImage image) {
    final allBytes = WriteBuffer();
    for (var plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final size = Size(image.width.toDouble(), image.height.toDouble());

    final rotation = InputImageRotation.rotation0deg; // or compute based on device

    final format = InputImageFormat.yuv420; // or appropriate format for your platform

    final planeData = image.planes.map(
          (plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final metadata = InputImageMetadata(
      size: size,
      rotation: rotation,
      format: format,
      bytesPerRow: image.planes[0].bytesPerRow,
    );

    return InputImage.fromBytes(bytes: bytes, metadata: metadata);
  }

  @override
  void onClose() {
    imageLabeler.close();
    super.onClose();
  }
}


/*
class ScenesenseController extends GetxController {
  CameraController? cameraController;
  late ImageLabeler imageLabeler;
  var labels = <ImageLabel>[].obs;
  var isBusy = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
    imageLabeler = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));
  }

  Future<void> initializeCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      Get.snackbar('Permission Denied', 'Please allow camera access');
      return;
    }

    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      Get.snackbar('Camera Error', 'No camera found on device');
      return;
    }

    cameraController = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.nv21,
    );

    await cameraController!.initialize();

    cameraController!.startImageStream(processCameraImage);
    update();
  }

  void processCameraImage(CameraImage image) async {
    if (isBusy.value) return;
    isBusy.value = true;

    final allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameraController!.description;
    final rotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
        InputImageRotation.rotation0deg;

    final format = InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;

    final plane = image.planes.first;

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: imageSize,
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );

    try {
      final result = await imageLabeler.processImage(inputImage);
      labels.value = result;
    } catch (e) {
      print("Error labeling image: $e");
    } finally {
      isBusy.value = false;
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    imageLabeler.close();
    super.onClose();
  }
}
*/
