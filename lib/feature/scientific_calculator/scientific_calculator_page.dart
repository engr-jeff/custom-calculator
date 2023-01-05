import 'package:flutter/material.dart';
import 'package:math_parser/math_parser.dart';

import 'package:chemical_engineering_calculator/feature/scientific_calculator/widgets/number_button_widget.dart';
import 'package:chemical_engineering_calculator/main.dart';
import 'package:chemical_engineering_calculator/utils/constants.dart';

class ScientificCalculatorPage extends StatefulWidget {
  const ScientificCalculatorPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<ScientificCalculatorPage> createState() => _ScientificCalculatorPageState();
}

class _ScientificCalculatorPageState extends State<ScientificCalculatorPage> {
  String resultText = '0';
  String displayText = '0';
  String expressionText = '';
  int _currentIndex = 1;

  buttonPressed(String character) {
    setState(() {
      if (character == '=') {
        displayText = resultText;
      } else if (displayText == '0' && singleDigitsList.any((digit) => digit == character)) {
        displayText = character;
      } else if (displayText != '0' && singleDigitsList.any((digit) => digit == character)) {
        displayText = displayText + character;
      } else if (displayText != '0' &&
          basicOperatorsList.any((operator) => operator != character) &&
          !basicOperatorsList.any((operator) => displayText.endsWith(operator))) {
        displayText = displayText + character;
      }

      if (character == 'AC') {
        displayText = '0';
        resultText = '0';
      }

      if (character == 'DEL' && displayText != '0') {
        displayText = displayText.substring(0, displayText.length - 4);
      }

      if (displayText.isEmpty) {
        displayText = '0';
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
          textCode: 'DEL',
          onTap: buttonPressed,
        ),
        CalculatorButton(
          displayText: 'AC',
          textCode: 'AC',
          onTap: buttonPressed,
        ),
      ],
    );

    final thirdBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          displayText: ' \u00d7 ',
          textCode: ' * ',
          onTap: buttonPressed,
        ),
        CalculatorButton(
          displayText: ' ÷ ',
          textCode: ' / ',
          onTap: buttonPressed,
        ),
      ],
    );

    final SecondBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          displayText: ' + ',
          textCode: ' + ',
          onTap: buttonPressed,
        ),
        // Minus sign (longer than default - string)
        CalculatorButton(
          displayText: ' - ',
          textCode: ' \u2212 ',
          onTap: buttonPressed,
        ),
      ],
    );

    final FirstBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          displayText: 'Ans',
          textCode: 'Ans',
          onTap: buttonPressed,
        ),
        CalculatorButton(
          displayText: '=',
          textCode: '=',
          onTap: buttonPressed,
        ),
      ],
    );

    return SafeArea(
      child: Scaffold(
          body: Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 16),
              color: const Color.fromARGB(255, 255, 148, 186),
              width: screenSize.width,
              height: 250,
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      alignment: Alignment.centerRight,
                      width: screenSize.width,
                      child: Text(displayText, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600))),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.centerRight,
                    width: screenSize.width,
                    child: Text(
                      resultText,
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                      color: const Color.fromARGB(255, 255, 129, 171),
                      width: screenSize.width * 0.6,
                      child: NumberButtonWidget(onTap: buttonPressed)),
                  Container(
                    color: const Color.fromARGB(255, 255, 129, 171),
                    width: screenSize.width * 0.4,
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        fourthBasicFunctionsRow,
                        thirdBasicFunctionsRow,
                        SecondBasicFunctionsRow,
                        FirstBasicFunctionsRow,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 255, 129, 171),
                    width: screenSize.width * 0.6,
                    child: NumberButtonWidget(onTap: buttonPressed),
                  ),
                  Container(
                    color: const Color.fromARGB(255, 255, 129, 171),
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
          ]),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              items: const [
                BottomNavigationBarItem(backgroundColor: Colors.red, label: 'Main Page', icon: Icon(Icons.home)),
                BottomNavigationBarItem(backgroundColor: Colors.red, label: 'Calculator', icon: Icon(Icons.calculate)),
                BottomNavigationBarItem(
                    backgroundColor: Colors.red, label: 'Custom', icon: Icon(Icons.dashboard_customize_rounded)),
                BottomNavigationBarItem(backgroundColor: Colors.red, label: 'Settings', icon: Icon(Icons.settings))
              ]),
          backgroundColor: const Color.fromARGB(255, 255, 129, 171)),
    );
  }
}