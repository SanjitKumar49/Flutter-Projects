import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  late final String text;
  late final VoidCallback onPressed;

  /*
  const CustomButton ({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  */
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // to do..
          },
          child: Text('Elevate Button'),
        ),
        SizedBox(height: 16),
        IconButton(
          onPressed: () {
            // Handle button press
          },
          icon: Icon(Icons.add)

        ),
        SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {

          },
          child: Text('OutLine Button'),
        ),
        SizedBox(height: 16),
        FloatingActionButton(
          onPressed: () {
            // Handle button press
          },
          child: Icon(Icons.access_alarm),
        ),
        SizedBox(height: 16),

        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Option 1',
              child: Text('Option 1'),
            ),
            PopupMenuItem<String>(
              value: 'Option 2',
              child: Text('Option 2'),
            ),
            PopupMenuItem<String>(
              value: 'Option 3',
              child: Text('Option 3'),
            ),
          ],
          onSelected: (String value) {
           print('key: $value');
          },
        ),
        SizedBox(height: 16),

      ],
    );
  }
}
