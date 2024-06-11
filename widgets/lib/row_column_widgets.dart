import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Row Wise'),
        Icon(Icons.star),
        Text('Star'),
        Icon(Icons.star),
      ],
    );
  }
}


class ColumnWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Column Wise'),
        Icon(Icons.star),
        Text('Star'),
        Icon(Icons.star),
      ],
    );
  }
}
