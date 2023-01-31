import 'package:chemical_engineering_calculator/utils/constants.dart';
import 'package:math_parser/math_parser.dart';

class CalculatorHandler {
  String displayText = '0';
  String resultText = '0';
  bool finishedCalculation = false;

  CalculatorHandler();

  void writeToDisplay(String input) {
    if (input == '=') {
      compute();
      finishedCalculation = true;

      return;
    }

    if (finishedCalculation && input != '=') {
      finishedCalculation = false;
      displayText = resultText + input;

      return;
    }

    if (input == 'AC') {
      displayText = '0';
      resultText = '0';

      return;
    }

    if (singleDigitsList.any((digit) => digit == input)) {
      displayText = displayText == '0' ? input : displayText + input;

      return;
    }

    if (basicOperatorsList.any((op) => op == input) && !basicOperatorsList.any((op) => displayText.endsWith(op))) {
      displayText = displayText + input;

      return;
    }

    if (input == 'DEL' && displayText != '0') {
      if (displayText.length == 1) {
        clearCalculator();

        return;
      }

      final length = displayText.length;
      displayText = displayText.substring(0, length - 1);

      return;
    }

    if (displayText.isEmpty) {
      displayText = '0';

      return;
    }
  }

  void compute() {
    final parsedExpr = MathNodeExpression.fromString(displayText);
    final value = parsedExpr.calc(MathVariableValues.none);

    resultText = value.runtimeType == int || value.runtimeType == double ? value.toString() : 'Cannot solve equation';
    displayText = resultText != 'Cannot solve equation' ? resultText : displayText;
  }

  void clearCalculator() {
    displayText = '0';
    resultText = '0';
  }
}
