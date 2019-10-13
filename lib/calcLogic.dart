import 'package:petitparser/petitparser.dart';

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

String _backspace(String x) {
  if (x.length == 1) {
    x = '';
  } else if (x.length != 1) {
    x = x.substring(0, x.length - 1);
  }
  return x;
}