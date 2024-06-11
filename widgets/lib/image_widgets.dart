import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ImageWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          print('Image Tapped');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(                                           // Create Snackbnar
              content: Text('Image Tapped'),
            ),
          );
        },
        child: Image.asset('assets/images/pic.jpg'),
      ),
    );
  }
}
