import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petitparser/petitparser.dart';

void main() => runApp(
      CalculatorApp(),
    );

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

String history = "";
String liveResult = "";
String launchDisplay = "";
bool opBtnAct = true;
bool decBtnAct = true;

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
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            // display area
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // history text
                Text(history),
                // live result text
                Text(liveResult),
                // launch display
                Text(
                  launchDisplay,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 2,
                  child: Container(
                    color: Colors.black26,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            // buttons area
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NormalButton(
                      btnName: '7',
                      onPressed: () {
                        launchDisplay = launchDisplay + '7';
                        if (isLastNum(launchDisplay)) {
                          liveResult = caLogic(launchDisplay).toString();
                        }
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '8',
                      onPressed: () {
                        launchDisplay = launchDisplay + '8';
                        if (isLastNum(launchDisplay)) {
                          liveResult = caLogic(launchDisplay).toString();
                        }
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '9',
                      onPressed: () {
                        launchDisplay = launchDisplay + '9';
                        if (isLastNum(launchDisplay)) {
                          liveResult = caLogic(launchDisplay).toString();
                        }
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '/',
                      onPressed: () {
                        launchDisplay = launchDisplay + '/';
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NormalButton(
                      btnName: '4',
                      onPressed: () {
                        launchDisplay = launchDisplay + '4';
                        if (isLastNum(launchDisplay)) {
                          liveResult = caLogic(launchDisplay).toString();
                        }
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '5',
                      onPressed: () {
                        launchDisplay = launchDisplay + '5';
                        if (isLastNum(launchDisplay)) {
                          liveResult = caLogic(launchDisplay).toString();
                        }
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '6',
                      onPressed: () {
                        launchDisplay = launchDisplay + '6';
                        if (isLastNum(launchDisplay)) {
                          liveResult = caLogic(launchDisplay).toString();
                        }
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '*',
                      onPressed: () {
                        launchDisplay = launchDisplay + '*';
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NormalButton(
                      btnName: '1',
                      onPressed: () {
                        launchDisplay = launchDisplay + '1';
                        if (isLastNum(launchDisplay)) {
                          liveResult = caLogic(launchDisplay).toString();
                        }
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '2',
                      onPressed: () {
                        launchDisplay = launchDisplay + '2';
                        if (isLastNum(launchDisplay)) {
                          liveResult = caLogic(launchDisplay).toString();
                        }
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '3',
                      onPressed: () {
                        launchDisplay = launchDisplay + '3';
                        if (isLastNum(launchDisplay)) {
                          liveResult = caLogic(launchDisplay).toString();
                        }
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '+',
                      onPressed: () {
                        launchDisplay = launchDisplay + '+';
                        setState(() {});
                      },
                    ),
                  ],
                ),
                // zero row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NormalButton(
                      btnName: '(',
                      onPressed: () {
                        launchDisplay = launchDisplay + '(';
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '0',
                      onPressed: () {
                        launchDisplay = launchDisplay + '0';
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: ')',
                      onPressed: () {
                        launchDisplay = launchDisplay + ')';
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: '-',
                      onPressed: () {
                        launchDisplay = launchDisplay + '-';
                        setState(() {});
                      },
                    ),
                  ],
                ),
                // clear and equal to
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NormalButton(
                      btnName: '<=',
                      onPressed: () {
                        if (launchDisplay.length != 0) {
                          launchDisplay = backspace(launchDisplay);
                        }
                        print(
                            "length of ld is ${launchDisplay.length} & its $launchDisplay");
                        if (launchDisplay.length == 0) {
                          launchDisplay = "";
                          liveResult = "";
                        } else if (isLastOp(launchDisplay)) {
                          liveResult = caLogic(launchDisplay.substring(
                                  0, launchDisplay.length - 1))
                              .toString();
                        } else if (isLastNum(launchDisplay) &&
                            launchDisplay.length > 1) {
                          liveResult = caLogic(launchDisplay).toString();
                        } else if (launchDisplay.length == 1) {
                          liveResult = launchDisplay;
                        }
                        print(launchDisplay);
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: 'Clear',
                      onPressed: () {
                        clearBtn();
                        setState(() {});
                      },
                    ),
                    NormalButton(
                      btnName: "=",
                      onPressed: () {
                        launchDisplay = caLogic(launchDisplay).toString();
                        setState(() {});
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class NormalButton extends StatelessWidget {
  final String btnName;
  final Function onPressed;

  NormalButton({this.btnName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.8),
      child: RaisedButton(
        elevation: 5,
        child: Text(btnName),
        onPressed: onPressed,
      ),
    );
  }
}

//takes a string and return its output after performing mathematical calculation
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

String backspace(String x) {
  if (x.length == 1) {
    x = '';
  } else if (x.length != 1) {
    x = x.substring(0, x.length - 1);
  }
  return x;
}

bool isLastDecimal(String x) {
  if (x[x.length - 1] == '.')
    return true;
  else
    return false;
}

bool isLastOp(String x) {
  if (x[x.length - 1] == '*' ||
      x[x.length - 1] == '+' ||
      x[x.length - 1] == '-' ||
      x[x.length - 1] == '/')
    return true;
  else
    return false;
}

bool isLastNum(String x) {
  if (x[x.length - 1] == '0' ||
      x[x.length - 1] == '1' ||
      x[x.length - 1] == '2' ||
      x[x.length - 1] == '3' ||
      x[x.length - 1] == '4' ||
      x[x.length - 1] == '5' ||
      x[x.length - 1] == '6' ||
      x[x.length - 1] == '7' ||
      x[x.length - 1] == '8' ||
      x[x.length - 1] == '9')
    return true;
  else
    return false;
}

//useless function, don't need this.

void clearBtn() {
  launchDisplay = "";
  liveResult = "";
  opBtnAct = true;
  decBtnAct = true;
}
