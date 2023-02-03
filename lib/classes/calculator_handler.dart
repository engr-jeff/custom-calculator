import 'package:chemical_engineering_calculator/extensions/string_ext.dart';
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
      clearCalculator();

      return;
    }

    if (singleDigitsList.any((digit) => digit == input)) {
      if (displayText != '0') return addToDisplayText(input);
      displayText = input;

      return;
    }

    if (input == '.' && singleDigitsList.any((element) => element == displayText.last)) {
      addToDisplayText(input);

      return;
    }

    if (basicOperatorsList.any((op) => op == input) && !basicOperatorsList.any((op) => displayText.endsWith(op))) {
      addToDisplayText(input);

      return;
    }

    //TODO: Make ' *10^' a named constant
    if (input == ' *10^' && !basicOperatorsList.any((op) => op == displayText.last)) {
      addToDisplayText(input);
    }

    if (input == 'DEL' && displayText != '0') {
      if (displayText.length == 1) {
        clearCalculator();

        return;
      }

      displayText = displayText.removeLast();
      return;
    }

    if (displayText.isEmpty) {
      displayText = '0';

      return;
    }
  }

  void addToDisplayText(String input) {
    displayText = displayText + input;
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
