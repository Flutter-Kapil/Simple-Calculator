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
      )
    );
  }
}


