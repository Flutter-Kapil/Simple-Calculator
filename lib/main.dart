import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petitparser/petitparser.dart';
import 'dart:core';
import 'calcLogic.dart';

void main() => runApp(
      CalculatorApp(),
    );

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  dynamic initialDisplay = "";
  var initialOutput = "";
  var finalDisplay = "";
  bool opBtnPress = false;
  bool decimalbtn = true;

  Widget _opBtn(String btnName) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
//        color: Colors.black,
        child: FlatButton(
          padding: EdgeInsets.all(2.0),
//          splashColor: Colors.white,
          child: Text(
            btnName,
            style: TextStyle(fontSize: 25), //removed color: Colors.white
          ),
//          color: Colors.black,
          onPressed: () {
            if (opBtnPress == false) {
              finalDisplay = finalDisplay + btnName;
              initialDisplay = finalDisplay;
              opBtnPress = true;
              decimalbtn =true;
            }
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
//        color: Colors.black,
        child: FlatButton(
          padding: EdgeInsets.all(2.0),
//          splashColor: Colors.white,
          child: Text(
            btnName,
            style: TextStyle(fontSize: 25), //color: Colors.white
          ),
//          color: Colors.black,
          onPressed: () {
            opBtnPress = false;
            finalDisplay = finalDisplay + btnName;
            initialDisplay = finalDisplay;
            liveresult = caLogic(initialDisplay).toString();
            print("num key press, initaldisplay: $initialDisplay ${initialDisplay.runtimeType}, finaldisplay: $finalDisplay ${finalDisplay.runtimeType}, ");
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _decBtn(String btnName) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
//        color: Colors.black,
        child: FlatButton(
          padding: EdgeInsets.all(2.0),
//          splashColor: Colors.white,
          child: Text(
            btnName,
            style: TextStyle(fontSize: 25), //color: Colors.white
          ),
//          color: Colors.black,
          onPressed: () {
            if(decimalbtn){
              print("b4 dec btn,\n initaldisplay: $initialDisplay ${initialDisplay.runtimeType}, finaldisplay: $finalDisplay ${finalDisplay.runtimeType},\n liveresult:$liveresult ");
              opBtnPress = false;
              finalDisplay = finalDisplay + btnName;
              initialDisplay = finalDisplay;
              liveresult = caLogic(initialDisplay).toString();
              print("after dec btn,\n initaldisplay: $initialDisplay ${initialDisplay.runtimeType}, finaldisplay: $finalDisplay ${finalDisplay.runtimeType},\n liveresult:$liveresult ");
              decimalbtn=false;
            }
            print("num key press, initaldisplay: $initialDisplay ${initialDisplay.runtimeType}, finaldisplay: $finalDisplay ${finalDisplay.runtimeType}, ");
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _delBtn() {
    return Container(
      margin: EdgeInsets.all(4.0),
//      color: Colors.black,
      child: FlatButton(
        padding: EdgeInsets.all(2.0),
//        splashColor: Colors.white,
        child: Icon(
          Icons.backspace,
//          color: Colors.white,
        ),
//        color: Colors.black,
        onPressed: () {
          print(
              "b4 delbtn, initialDisplay:$initialDisplay , finalDisplay:$finalDisplay , opBtnPress:$opBtnPress ");
          var x = initialDisplay.length;
          int y = x - 1;
          String del;
          if (y >= 1) {
            del = initialDisplay.substring(0, y);
          }
          if (y == 0) {
            del = '0';
          }
          initialDisplay = del;
          finalDisplay = initialDisplay;
          var z = finalDisplay.length - 1;
          var lastChar = finalDisplay.substring(z);
          if (lastChar == '+' ||
              lastChar == '-' ||
              lastChar == '*' ||
              lastChar == '/') {
            opBtnPress = true;
          } else if (lastChar == '1' ||
              lastChar == '2' ||
              lastChar == '3' ||
              lastChar == '4' ||
              lastChar == '5' ||
              lastChar == '6' ||
              lastChar == '7' ||
              lastChar == '8' ||
              lastChar == '9' ||
              lastChar == '0') {
            opBtnPress = false;
          }
          liveresult = caLogic(initialDisplay).toString();
          print(
              "del btn , initialDisplay:$initialDisplay , finalDisplay:$finalDisplay , opBtnPress:$opBtnPress lastChar:$lastChar");
          setState(() {});
        },
      ),
    );
  }

  Widget _keypadArea() {
    return Column(
      children: <Widget>[
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
                child: _delBtn(),
              ),
              _numBtn('0'),
              _decBtn('.'),
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
                  child: FlatButton(
                    padding: EdgeInsets.all(2.0),
//                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Clear',
                      style: TextStyle(fontSize: 25), //, color: Colors.white30
                    ),
//                    color: Colors.black,
                    onPressed: () {
                      decimalbtn=true;
                      liveresult="";
                      historyVisible = false;
                      setState(() {
                        initialDisplay = "0";
                        finalDisplay = "";
                        history = "";
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    if (!historyVisible) {
                      historyVisible = true;
                    } else {
                      historyVisible = false;
                    }
                    setState(() {});
                  },
                  child: Text(
                    "History",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(2.0),
//                    splashColor: Colors.blueGrey,
                    child: Text(
                      '=',
                      style: TextStyle(fontSize: 25), //, color: Colors.white30
                    ),
//                    color: Colors.black,
                    onPressed: () {
                      decimalbtn =true;
                      history = history + finalDisplay;
                      print("history: $history"); // debug print
                      print("before equal key, initaldisplay: $initialDisplay ${initialDisplay.runtimeType}, finaldisplay: $finalDisplay ${finalDisplay.runtimeType}, ");
                      initialDisplay = caLogic(finalDisplay);
                      initialDisplay = "$initialDisplay";
                      finalDisplay = initialDisplay;
                      history = history + " = " + finalDisplay + ",\n";
                      print("history: $history"); // debug print
                      print("after equal key, initaldisplay: $initialDisplay ${initialDisplay.runtimeType}, finaldisplay: $finalDisplay ${finalDisplay.runtimeType}, ");
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _displayArea() {
    return Container(
      padding: EdgeInsets.all(10.0),
//      color: Colors.blue.shade600,
      child: Text(
        "$initialDisplay",
        style: TextStyle(fontSize: 40),
      ),
      alignment: Alignment.bottomRight,
    );
  }

  Brightness _theme = Brightness.light;
  static Color _defaultAppbarColor = Colors.white;
  Color appbarColor = _defaultAppbarColor;
  String history = "";
  String liveresult = "";
  bool historyVisible = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: appbarColor,
        brightness: _theme,
        textTheme: Typography().black,
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                //on pressing button switch between light/dark theme
                if (_theme == Brightness.light) {
                  appbarColor = null;
                  _theme = Brightness.dark;
                } else {
                  appbarColor = _defaultAppbarColor;
                  _theme = Brightness.light;
                }

                setState(() {});
              },
              icon: Icon(Icons.color_lens),
            ),
          ],
          title: Text('Simple Calculator'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Visibility(
                    visible: historyVisible,
                    child: Text(
                      history,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Text(liveresult,style: TextStyle(fontSize: 20),),
                  _displayArea(),
                  SizedBox(
                    height: 0.5,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: _keypadArea(),
            )
          ],
        ),
//        backgroundColor: Colors.black,
      ),
    );
  }
}


