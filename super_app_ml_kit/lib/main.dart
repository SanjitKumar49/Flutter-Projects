import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app_ml_kit/app/bindings/InitialBinding.dart';
import 'package:super_app_ml_kit/app/bindings/camera_binding.dart';
import 'package:super_app_ml_kit/app/screen/camera_view.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super App',
      initialBinding: CameraBinding(),
      home: MyCameraViewScreen(),
      // initialRoute: MyCameraViewScreen(),
      // getPages: MyCameraViewScreen(),
    );
  }
}
