import 'package:petitparser/petitparser.dart';

caLogic() {
  final builder = ExpressionBuilder();

  builder.group()
    ..primitive(digit()
        .plus()
        .seq(char('.').seq(digit().plus()).optional())
        .flatten()
        .trim()
        .map((a) => num.tryParse(a)))
    ..wrapper(char('(').trim(), char(')').trim(), (l, a, r) => a);

  // negation is a prefix operator
  builder.group()..prefix(char('-').trim(), (op, a) => -a);

// power is right-associative
  var math;
  builder.group()..right(char('^').trim(), (a, op, b) => math.pow(a, b));

// multiplication and addition are left-associative
  builder.group()
    ..left(char('*').trim(), (a, op, b) => a * b)
    ..left(char('/').trim(), (a, op, b) => a / b);
  builder.group()
    ..left(char('+').trim(), (a, op, b) => a + b)
    ..left(char('-').trim(), (a, op, b) => a - b);

  final parser = builder.build().end();
  //to below function for solution
  var finalOutput = parser.parse('24*(2)');
  print(finalOutput);
  // above example from https://github.com/petitparser/dart-petitparser#writing-a-more-complicated-grammar
}
