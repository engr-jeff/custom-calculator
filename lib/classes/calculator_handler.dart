// ignore_for_file: unused_element

import 'dart:js_interop';
import 'dart:math';

import 'package:chemical_engineering_calculator/extensions/string_ext.dart';
import 'package:chemical_engineering_calculator/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:math_parser/math_parser.dart';

class CalculatorHandler {
  String displayText = '0';
  String resultText = '0';
  //TODO: Add degrees/radians functionality
  //TODO: Add conversion functionality (SD)
  //TODO: Add fraction handling
  //TODO: Add arrows functionality including editable text field (high complexity)

  /// Used when pressing equals button
  bool finishedCalculation = false;

  static const _maxLines = 80;

  /// Precision for shift-solve calculation
  static const _precision = 1e-10;
  static final _regformat = NumberFormat('###,###.########', 'en_US');
  static final _sciformat = NumberFormat('###.0#E0#', 'en_US');

  CalculatorHandler();

  void writeToDisplay(String input) {
    if (input == 'AC') {
      return clearCalculator();
    }

    if (input == 'DEL' && displayText != '0') {
      if (displayText.length == 1) {
        return clearCalculator();
      }

      displayText = displayText.removeLast();

      return;
    }

    if (displayText.length >= _maxLines) return;

    if (input == '=' && !finishedCalculation) {
      _compute();
      finishedCalculation = true;

      return;
    }

    if (finishedCalculation && input != '=') {
      finishedCalculation = false;

      displayText = displayText == '0'
          ? input
          : _regformat.format(double.tryParse(resultText) ?? 0).replaceAll(RegExp(r','), '') + input;

      return;
    }

    if (singleDigitsList.any((digit) => digit == input)) {
      if (displayText != '0') return _addToDisplayText(input);
      displayText = input;

      return;
    }

    if (input == '.' && singleDigitsList.any((element) => element == displayText.last)) {
      _addToDisplayText(input);

      return;
    }

    if (basicOperatorsList.any((op) => op == input) && !basicOperatorsList.any((op) => displayText.endsWith(op))) {
      _addToDisplayText(input);

      return;
    }

    if (input == timesTenRaisedTo && !basicOperatorsList.any((op) => op == displayText.last)) {
      _addToDisplayText(input);
    }

    if (displayText.isEmpty) {
      displayText = '0';

      return;
    }
  }

  void clearCalculator() {
    displayText = '0';
    resultText = '0';
  }

  void _addToDisplayText(String input) {
    displayText = displayText + input;
  }

  void _compute() {
    final parsedExpr = MathNodeExpression.fromString(displayText, isMinusNegativeFunction: true);
    final value = parsedExpr.calc(MathVariableValues.none);
    final formattedValue = value >= pow(10, 12) ? _sciformat.format(value) : _regformat.format(value);

    resultText = value.isNull ? 'Cannot solve equation' : formattedValue;
    displayText = resultText != 'Cannot solve equation' ? value.toString() : displayText;
  }

  /// Derivative function for shift solve
  double _derivative(double x0, Function func) => func(x0 + deltaH) - func(x0) / deltaH;

  /// Function for using shift solve feature
  double _newtonRaphson(double x0) {
    int iterations = 0;
    double currentX = x0;

    while (iterations < 1000) {
      double f_initial = pow(currentX, 2) + currentX * 6 + 9 - currentX * sin(currentX);
      double f_prime = _derivative(currentX, (x) => f_initial);
      double x_new = currentX - f_initial / f_prime;
      if ((x_new - currentX).abs() < _precision) {
        return x_new;
      }
      currentX = x_new;
      iterations += 1;
    }

    return currentX;
  }
}
