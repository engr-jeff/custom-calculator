import 'package:flutter_test/flutter_test.dart';
import 'package:math_parser/math_parser.dart';

void main() {
  String calculateInMathParser(String equation) {
    final parsedExpr = MathNodeExpression.fromString(equation);
    final value = parsedExpr.calc(MathVariableValues.none);

    return value.toString();
  }

  final startTime = DateTime.now();
  // Addition Tests

  group('Arithmetic tests for math parser', () {
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

    // Subtraction Tests
    test('Subtraction of large positive integers', () {
      final computedDiff = calculateInMathParser('84923482393423 - 124982304238432');
      const realDiff = '-40058821845009';
      expect(computedDiff, realDiff);
    });

    test('Subtraction of large opposite signed integers', () {
      final computedDiff = calculateInMathParser('-230921312093 - 203203203203');
      const realDiff = '-434124515296';
      expect(computedDiff, realDiff);
    });

    test('Subtraction of large negative integers', () {
      final computedDiff = calculateInMathParser('-230921312093 - -203203203203');
      const realDiff = '-27718108890';
      expect(computedDiff, realDiff);
    });

    // Multiplication Tests
    test('Multiplication of positive integers', () {
      final computedProduct = calculateInMathParser('59023 * 10291');
      const realProduct = '607405693';
      expect(computedProduct, realProduct);
    });

    test('Multiplication of large opposite signed integers', () {
      final computedProduct = calculateInMathParser('-230 * 2003');
      const realProduct = '-460690';
      expect(computedProduct, realProduct);
    });

    test('Multiplication of large negative integers', () {
      final computedProduct = calculateInMathParser('-230 * -2003');
      const realProduct = '460690';
      expect(computedProduct, realProduct);
    });

    test('Multiplication by zero', () {
      final computedProduct = calculateInMathParser('230 * 0');
      const realProduct = '0';
      expect(computedProduct, realProduct);
    });

    // Division Tests
    test('Division of integers with no remainder', () {
      final computedQuotient = calculateInMathParser('16807 / 7');
      const realQuotient = '2401.0';
      expect(computedQuotient, realQuotient);
    });

    test('Division of integers with rational leftover (remainder/divisor)', () {
      final computedQuotient = calculateInMathParser('221/2');
      const realQuotient = '110.5';
      expect(computedQuotient, realQuotient);
    });

    test('Division of integers with longer rational leftover (remainder/divisor)', () {
      final computedQuotient = calculateInMathParser('221/8');
      const realQuotient = '27.625';
      expect(computedQuotient, realQuotient);
    });

    test('Division of integers with repeating rational leftover (remainder/divisor)', () {
      final computedQuotient = calculateInMathParser('221/3');
      final formattedQuotient = double.parse(computedQuotient).toStringAsFixed(8);
      const realQuotient = '73.66666667';
      expect(formattedQuotient, realQuotient);
    });

    test('Division of integers with irrational leftover (remainder/divisor)', () {
      final computedQuotient = calculateInMathParser('16806 / 7');
      final formattedQuotient = double.parse(computedQuotient).toStringAsFixed(8);
      const realQuotient = '2400.85714286';
      expect(formattedQuotient, realQuotient);
    });

    test('Division by zero', () {
      final computedProduct = calculateInMathParser('230 / 0');
      // may be infinity or undefined, whichever the package returns
      const realProduct = 'Infinity';
      expect(computedProduct, realProduct);
    });
  });

  //FOR CHECKING OF TEST RUNNING TIME
  final endTime = DateTime.now();
  print('time elapsed in milliseconds: ${endTime.difference(startTime).inMilliseconds}');
}
