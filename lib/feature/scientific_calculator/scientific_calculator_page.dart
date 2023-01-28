import 'package:chemical_engineering_calculator/custom_calculator_app.dart';
import 'package:chemical_engineering_calculator/feature/main_page/widgets/number_button_widget.dart';
import 'package:chemical_engineering_calculator/utils/constants.dart';
import 'package:chemical_engineering_calculator/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:math_parser/math_parser.dart';

class ScientificCalculatorPage extends StatefulWidget {
  const ScientificCalculatorPage({super.key});

  @override
  State<ScientificCalculatorPage> createState() => _ScientificCalculatorPageState();
}

class _ScientificCalculatorPageState extends State<ScientificCalculatorPage> {
  String resultText = '0';
  String displayText = '0';
  String expressionText = '';
  int _currentIndex = 1;

  //TODO: Implement this function in [CalculatorHandler] class
  buttonPressed(String character) {
    setState(() {
      if (character == '=') {
        displayText = resultText;
      }

      if (character == 'AC') {
        displayText = '0';
        resultText = '0';
      }

      if (displayText.isEmpty) {
        displayText = '0';
      }

      if (displayText == '0' && singleDigitsList.any((digit) => digit == character)) {
        displayText = character;
      } else if (displayText != '0' && singleDigitsList.any((digit) => digit == character)) {
        displayText = displayText + character;
      } else if (displayText != '0' &&
          basicOperatorsList.any((operator) => operator != character) &&
          !basicOperatorsList.any((operator) => displayText.endsWith(operator))) {
        displayText = displayText + character;
      }

      if (character == 'DEL' && displayText != '0') {
        displayText = displayText.substring(0, displayText.length - 4);
      }
    });

    setState(() {
      if (singleDigitsList.any((element) => element == character) ||
          singleDigitsList.any((element) => displayText.endsWith(element)) ||
          character == '=') {
        final parsedExpr =
            MathNodeExpression.fromString(displayText.substring(0, displayText.length).split(' ').join());
        final value = parsedExpr.calc(MathVariableValues.none);
        resultText = value.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final fourthBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          displayText: 'DEL',
          onTap: buttonPressed,
        ),
        CalculatorButton(
          displayText: 'AC',
          onTap: buttonPressed,
        ),
      ],
    );

    final thirdBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          textCode: '*',
          displayText: '\u00d7',
          onTap: buttonPressed,
        ),
        CalculatorButton(
          textCode: '/',
          displayText: '÷',
          onTap: buttonPressed,
        ),
      ],
    );

    final SecondBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          displayText: '+',
          onTap: buttonPressed,
        ),
        // Minus sign (longer than default - string)
        CalculatorButton(
          textCode: '-',
          displayText: '\u2212',
          onTap: buttonPressed,
        ),
      ],
    );

    final FirstBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          displayText: 'Ans',
          onTap: buttonPressed,
        ),
        CalculatorButton(
          displayText: '=',
          onTap: buttonPressed,
        ),
      ],
    );

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: PinkTheme.displayBackgroundColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
          ),
          width: screenSize.width,
          height: 250,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                width: screenSize.width,
                child: Text(displayText, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: screenSize.width,
                child: Text(resultText, style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                color: PinkTheme.buttonBackgroundColor,
                width: screenSize.width * 0.6,
                child: NumberButtonWidget(onTap: buttonPressed),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                color: PinkTheme.buttonBackgroundColor,
                width: screenSize.width * 0.6,
                child: NumberButtonWidget(onTap: buttonPressed),
              ),
              Container(
                color: PinkTheme.buttonBackgroundColor,
                width: screenSize.width * 0.4,
                child: Table(
                  children: [
                    fourthBasicFunctionsRow,
                    thirdBasicFunctionsRow,
                    SecondBasicFunctionsRow,
                    FirstBasicFunctionsRow,
                  ],
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
