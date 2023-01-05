import 'package:flutter_test/flutter_test.dart';
import 'package:math_parser/math_parser.dart';

void main() {
  String calculateInMathParser(String equation) {
    final parsedExpr = MathNodeExpression.fromString(equation);
    final value = parsedExpr.calc(MathVariableValues.none);

    return value.toString();
  }

  test('Addition of large positive integers', () {
    final computedSum = calculateInMathParser('84923482393423 + 124982304238432');
    const realSum = '209905786631855';
    expect(computedSum, realSum);
  });

  test('Addition of large opposite signed integers', () {
    final computedSum = calculateInMathParser('-230921312093 + 203203203203');
    const realSum = '-27718108890';
    expect(computedSum, realSum);
  });

  test('Addition of large negative integers', () {
    final computedSum = calculateInMathParser('-230921312093 + -203203203203');
    const realSum = '-434124515296';
    expect(computedSum, realSum);
  });
}
