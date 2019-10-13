import 'dart:core';

import 'package:flutter/material.dart';
import 'dart:core';


void main() => runApp(
      CalculatorApp(),
    );

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}
String history="";
String liveResult="";
String launchDisplay="0";

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
              flex: 4, child: Column(
              children: <Widget>[
                // history text
                Text(history),
                // live result text
                Text(liveResult),
                // launch display
                Text(launchDisplay),
              ],
            ),
            ),
            Expanded(
              // buttons area
              flex: 5,
              child: Column(
                children: <Widget>[],
              ),
            )
          ],
        ),
      )
    );
  }
}


