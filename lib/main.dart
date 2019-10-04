import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: CalculatorApp(),
    ));
Widget _calBtn(String btnName) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(4.0),
      color: Colors.blue.shade400,
      child: FlatButton(
        padding: EdgeInsets.all(2.0),
        splashColor: Colors.blueGrey,
        child: Text(
          btnName,
          style: TextStyle(fontSize: 25),
        ),
        color: Colors.yellow,
      ),
    ),
  );
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Simple Calculator'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.black26,
                child: Text(
                  "Output",
                  style: TextStyle(fontSize: 40),
                ),
                alignment: Alignment.bottomRight,
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                  _calBtn('1'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
