import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(15.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(color: Colors.black, width: 3.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        'Hello Container',
        style: TextStyle(color: Colors.blue, fontSize: 20.0),
      ),
    );
  }
}
