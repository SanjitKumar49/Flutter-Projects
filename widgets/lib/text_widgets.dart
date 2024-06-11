import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidgets extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Center(
       child: Text(
         'Advance Text Style',
         style: TextStyle(
           fontSize:30.0,
           color: Colors.green,
           fontWeight: FontWeight.w600,
           fontStyle: FontStyle.italic,
           letterSpacing:5.0,
           backgroundColor: Colors.yellow,
           decoration: TextDecoration.underline,
           decorationColor: Colors.red,
           decorationStyle: TextDecorationStyle.dashed,
           shadows: [
             Shadow(
               blurRadius: 10.0,
               color: Colors.black45,
               offset: Offset(5.0,5.0),
             )
           ]
         ),

       ),
     );
  }
}