import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_pages.dart';

class HomeScreen extends StatelessWidget {
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
              title: "SceneSense",
              description: "Label objects in images",
              icon: Icons.image,
              colors: [Colors.orange, Colors.deepOrangeAccent],
              onTap: () => Get.toNamed(Routes.SCENESENSE),
            ),
            SizedBox(height: 20),
            FeatureCard(
              title: "TrackIt",
              description: "Detect and track objects live",
              icon: Icons.track_changes,
              colors: [Colors.teal, Colors.greenAccent],
              onTap: () => Get.toNamed(Routes.TRACKIT),
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
