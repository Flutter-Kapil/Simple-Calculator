import 'package:flutter/material.dart';
import 'dart:core';


void main() => runApp(
      CalculatorApp(),
    );

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Simple Calculator"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.invert_colors),
              onPressed: (){

              },
            )
          ],
        ),
        body:Column(
          children: <Widget>[
            Expanded(
              // display area
              flex: 4,
            ),
            Expanded(
              // buttons area
              flex: 5,
              child: ,
            )
          ],
        ),
      )
    );
  }
}


