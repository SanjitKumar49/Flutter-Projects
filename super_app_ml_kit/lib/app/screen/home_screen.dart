import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app_ml_kit/app/screen/new/object_detection_screen.dart';
import 'package:super_app_ml_kit/app/screen/new/start_screen.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_pages.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/*
class _HomeScreenState extends State<HomeScreen> {

   Future<void> getCamera() async {
     final cameras = await availableCameras();

   }
   @override
  void initState() {
    // TODO: implement initState
     getCamera();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final List<CameraDescription> cameras;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Super ML App'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.logout,color: Colors.white,),
            onPressed: () {
              authController.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FeatureCard(
              title: "TextSnap",
              description: "OCR System for text recognition",
              icon: Icons.text_snippet,
              colors: [Colors.deepPurple, Colors.purpleAccent],
              onTap: () => Get.toNamed(Routes.TEXTSNAP),
            ),
            SizedBox(height: 20),
            FeatureCard(
              title: "Object Detection",
              description: "Objects in Camera",
              icon: Icons.image,
              colors: [Colors.orange, Colors.deepOrangeAccent],
              onTap: (){
                Get.to(()=>StartScreen(cameras: ,),transition: Transition.rightToLeft);
              },
            ),
            // SizedBox(height: 20),
            // FeatureCard(
            //   title: "TrackIt",
            //   description: "Detect and track objects live",
            //   icon: Icons.track_changes,
            //   colors: [Colors.teal, Colors.greenAccent],
            //   onTap: () => Get.toNamed(Routes.TRACKIT),
            // ),
          ],
        ),
      ),
    );
  }
}
*/

class _HomeScreenState extends State<HomeScreen> {
  List<CameraDescription>? cameras; // Store cameras here

  Future<void> getCamera() async {
    cameras = await availableCameras();
    setState(() {}); // Refresh UI after loading cameras
  }

  @override
  void initState() {
    super.initState();
    getCamera();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Super ML App'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              authController.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FeatureCard(
              title: "TextSnap",
              description: "OCR System for text recognition",
              icon: Icons.text_snippet,
              colors: [Colors.deepPurple, Colors.purpleAccent],
              onTap: () => Get.toNamed(Routes.TEXTSNAP),
            ),
            SizedBox(height: 20),
            FeatureCard(
              title: "Object Detection",
              description: "Objects in Camera",
              icon: Icons.image,
              colors: [Colors.orange, Colors.deepOrangeAccent],
              onTap: () {
                if (cameras != null) {
                  Get.to(() => StartScreen(cameras: cameras!),
                      transition: Transition.rightToLeft);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cameras not ready')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> colors;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 4),
            )
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white.withOpacity(0.3),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(description,
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
