import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_widgets.dart';

class InkWellExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CustomButton()),
        );
        // Handle tap event
        print('Container tapped!');
      },
      child: CustomContainer(),
    );
  }
}

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      child: Text(
        'Tap Me',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
