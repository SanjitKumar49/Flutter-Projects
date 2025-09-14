import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app_ml_kit/app/controllers/auth_controller.dart';
import 'package:super_app_ml_kit/app/routes/app_pages.dart';

class SignInScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign In", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              onPressed: () {
                authController.signIn(emailController.text, passwordController.text);
              },
              child: Text("Sign In"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.toNamed(Routes.SIGNUP),
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
