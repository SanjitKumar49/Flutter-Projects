import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleavatarWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/pic.jpg'),
        ),
        SizedBox(height: 20),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: Text(
            'A',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        SizedBox(height: 20),
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1080&h=893&q=70&fm=webp'),
        ),
        SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.green,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
