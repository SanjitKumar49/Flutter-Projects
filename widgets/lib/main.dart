import 'package:flutter/material.dart';
import 'package:widgets/row_column_widgets.dart';
import 'package:widgets/scrollView_widgets.dart';
import 'package:widgets/text_widgets.dart';

import 'CircleAvatar_widgets.dart';
import 'button_widgets.dart';
import 'container_widgets.dart';
import 'image_widgets.dart';
import 'inlink_widgets.dart';
import 'listTile_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("All Widgets.!"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [

            // CustomContainer(),
            // TextWidgets(),
            // CustomButton(),
            // ImageWidgets(),

          /*  RowWidgets(),
            SizedBox(height: 20),
            ColumnWidgets(),
         */
            //InkWellExample(),


            // ListViewExamples()

            CircleavatarWidgets()
          ],
        )
            //  child: TextWidgets(),  --> For single widgets show
            ),
      ),
    );
  }
}

