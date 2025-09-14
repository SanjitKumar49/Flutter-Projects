import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app_ml_kit/app/controllers/auth_controller.dart';
import 'package:super_app_ml_kit/app/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
  _checkLogin();
    super.initState();
  }
  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString("uid");

    await Future.delayed(Duration(seconds: 2)); // Splash animation delay

    if (uid != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.SIGNIN);
    }
  }
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    // Future.delayed(Duration(seconds: 2), () {
    //   if (authController.isLoggedIn()) {
    //     Get.offAllNamed(Routes.HOME);
    //   } else {
    //     Get.offAllNamed(Routes.SIGNIN);
    //   }
    // });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent]),
              ),
              child: Icon(Icons.flutter_dash, size: 80, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text("Super App", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
