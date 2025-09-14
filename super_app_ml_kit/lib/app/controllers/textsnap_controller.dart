import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:translator/translator.dart';

class TextSnapController extends GetxController {
  var pickedImage = Rxn<File>();
  var recognizedText = ''.obs;
  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  Future<void> pickImage() async {
    // final status = await Permissionfil.request();
    //final status = await Permission.storage.request();

    // if (!status.isGranted) {
    //   Get.snackbar('Permission Denied', 'Please allow gallery access');
    //   return;
    // }
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
      await performTextRecognition();
    }
  }

  /// Pick image using camera
  Future<void> captureImage() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      Get.snackbar('Permission Denied', 'Please allow camera access');
      return;
    }
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImage.value = File(image.path);
      await performTextRecognition();
    }
  }

  /// Perform text recognition using ML Kit
  Future<void> performTextRecognition() async {
    if (pickedImage.value == null) return;

    final inputImage = InputImage.fromFile(pickedImage.value!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      final recognized = await textRecognizer.processImage(inputImage);
      String resultText = '';
      for (TextBlock block in recognized.blocks) {
        for (TextLine line in block.lines) {
          resultText += line.text + '\n';
        }
      }
      recognizedText.value = resultText.isEmpty ? 'No text found' : resultText;
    } catch (e) {
      Get.snackbar('Error', 'Failed to recognize text');
    } finally {
      textRecognizer.close();
    }
  }



  FlutterTts flutterTts = FlutterTts();
  GoogleTranslator translator = GoogleTranslator();

  // Text to Speech Controls
  var isSpeaking = false.obs;
  var isPaused = false.obs;

  // Text to Speech Methods
  Future<void> speak() async {
  if (recognizedText.value.isNotEmpty) {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setPitch(1.0);
  await flutterTts.speak(recognizedText.value);
  isSpeaking.value = true;
  }
  }

  Future<void> pause() async {
    await flutterTts.pause();
    isPaused.value = true;
  }
  Future<void> resume() async {
    await flutterTts.speak(recognizedText.value);
    isPaused.value = false;
  }


  Future<void> stop() async {
  await flutterTts.stop();
  isSpeaking.value = false;
  isPaused.value = false;
  }

  // Translate Text
  Future<String> translate(String toLangCode) async {
  if (recognizedText.value.isEmpty) return "No text to translate.";
  var translation = await translator.translate(recognizedText.value, to: toLangCode);
  return translation.text;
  }

}
