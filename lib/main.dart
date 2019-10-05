import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petitparser/petitparser.dart';

void main() => runApp(
      MaterialApp(
        home: CalculatorApp(),
      ),
    );
var initialDisplay = "0";
var initialOutput = "";
var finalDisplay = "";
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
        onPressed: () {
          finalDisplay = finalDisplay + btnName;
        },
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
                  _calBtn('7'),
                  _calBtn('8'),
                  _calBtn('9'),
                  _calBtn('/'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _calBtn('4'),
                  _calBtn('5'),
                  _calBtn('6'),
                  _calBtn('*'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _calBtn('1'),
                  _calBtn('2'),
                  _calBtn('3'),
                  _calBtn('-'),
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
                  _calBtn('0'),
                  _calBtn('.'),
                  _calBtn('+'),
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
                          setState(() {
                            initialDisplay = finalDisplay;
                          });
                          initialDisplay = finalDisplay;
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

caLogic() {
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
//  String fromButtons =
//      ""; // add all the strings as soon as user taps on = and pass it
  //to below function for solution
  var finalOutput = parser.parse('$finalDisplay');
  print(finalOutput);
  // above example from https://github.com/petitparser/dart-petitparser#writing-a-more-complicated-grammar
}
