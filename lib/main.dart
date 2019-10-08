import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petitparser/petitparser.dart';
import 'dart:core';

void main() => runApp(
      MaterialApp(
        home: CalculatorApp(),
      ),
    );

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  dynamic initialDisplay = "";
  var initialOutput = "";
  var finalDisplay = "";


  Widget _opBtn(String btnName) {
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
          onPressed: () {
            finalDisplay = finalDisplay + btnName;
            initialDisplay = finalDisplay;
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _numBtn(String btnName) {
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
          onPressed: () {
            finalDisplay = finalDisplay + btnName;
            initialDisplay = finalDisplay;
            setState(() {});
          },
        ),
      ),
    );
  }

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
                  "$initialDisplay",
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
                  _numBtn('7'),
                  _numBtn('8'),
                  _numBtn('9'),
                  _opBtn('/'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _numBtn('4'),
                  _numBtn('5'),
                  _numBtn('6'),
                  _opBtn('*'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _numBtn('1'),
                  _numBtn('2'),
                  _numBtn('3'),
                  _opBtn('-'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.all(2.0),
                      splashColor: Colors.blueGrey,
                      child: Icon(Icons.backspace),
                      color: Colors.yellow,
                      onPressed: () {
                        print("Debug on pressing delete arrow"
                            " initiaDisplay = $initialDisplay finaldisplay = $finalDisplay");
                        var x = initialDisplay.length;
                        int y = x - 1;
                        String del = initialDisplay.substring(0, y);
                        initialDisplay = del;
                        finalDisplay = initialDisplay;
                        print("Debug on pressing delete arrow"
                            "initiaDisplay = $initialDisplay finaldisplay = $finalDisplay");
                        setState(() {});
                      },
                    ),
                  ),
                  _numBtn('0'),
                  _numBtn('.'),
                  _opBtn('+'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.blue.shade400,
                      child: FlatButton(
                        padding: EdgeInsets.all(2.0),
                        splashColor: Colors.blueGrey,
                        child: Text(
                          'Clear',
                          style: TextStyle(fontSize: 25),
                        ),
                        color: Colors.yellow,
                        onPressed: () {
                          setState(() {
                            initialDisplay = "0";
                            finalDisplay = "";
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.blue.shade400,
                      child: FlatButton(
                        padding: EdgeInsets.all(2.0),
                        splashColor: Colors.blueGrey,
                        child: Text(
                          '=',
                          style: TextStyle(fontSize: 25),
                        ),
                        color: Colors.yellow,
                        onPressed: () {
                          initialDisplay = caLogic(finalDisplay);
                          initialDisplay = "$initialDisplay";
                          finalDisplay = initialDisplay;
                          print(
                              "value of initialDisplay is $initialDisplay and its type is ${initialDisplay.runtimeType}");
                          print(
                              "value of finalDisplay is $finalDisplay and its type is ${finalDisplay.runtimeType}");
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

caLogic(String x) {
  final builderC = ExpressionBuilder();

  builderC.group()
    ..primitive(digit()
        .plus()
        .seq(char('.').seq(digit().plus()).optional())
        .flatten()
        .trim()
        .map((a) => num.tryParse(a)))
    ..wrapper(char('(').trim(), char(')').trim(), (l, a, r) => a);

  // negation is a prefix operator
  builderC.group()..prefix(char('-').trim(), (op, a) => -a);

// power is right-associative
  var math;
  builderC.group()..right(char('^').trim(), (a, op, b) => math.pow(a, b));

// multiplication and addition are left-associative
  builderC.group()
    ..left(char('*').trim(), (a, op, b) => a * b)
    ..left(char('/').trim(), (a, op, b) => a / b);
  builderC.group()
    ..left(char('+').trim(), (a, op, b) => a + b)
    ..left(char('-').trim(), (a, op, b) => a - b);

  final parser = builderC.build().end();
  return parser.parse(x).value;
}
