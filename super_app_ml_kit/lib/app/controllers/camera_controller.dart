import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class MyCameraController extends GetxController {
  late CameraController cameraController;
  var detectedObjects = <String>[].obs;
  bool isDetecting = false;

  final String apiKey = '682a6421176f91939ae3f0f064cefba2bf21a05e';
  //final apiKey = 'AIzaSyCG-OhxdVb9Sr8pPnrGEzMKmP2rDWAWGBo';

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await cameraController.initialize();
    update();

    startImageStream();
  }

  void startImageStream() {
    cameraController.startImageStream((CameraImage image) async {
      if (isDetecting) return;
      isDetecting = true;

      try {
        final file = await convertImage(image);
        await sendImageToVision(file);
      } catch (e) {
        print('Error: $e');
      } finally {
        isDetecting = false;
      }
    });
  }

  Future<File> convertImage(CameraImage image) async {
    final directory = await getTemporaryDirectory();
    final filePath = path.join(directory.path, '${DateTime.now()}.jpg');

    final bytes = image.planes[0].bytes;
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> sendImageToVision(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final url = 'https://vision.googleapis.com/v1/images:annotate?key=$apiKey';

    final body = jsonEncode({
      "requests": [
        {
          "image": {"content": base64Image},
          "features": [
            {"type": "OBJECT_LOCALIZATION", "maxResults": 5}
          ]
        }
      ]
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final annotations = result['responses'][0]['localizedObjectAnnotations'] as List?;
      if (annotations != null) {
        detectedObjects.clear();
        for (var obj in annotations) {
          detectedObjects.add(obj['name']);
        }
      }
    } else {
      print('Error: ${response.body}');
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
