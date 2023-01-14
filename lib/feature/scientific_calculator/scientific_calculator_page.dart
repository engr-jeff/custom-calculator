import 'package:chemical_engineering_calculator/custom_calculator_app.dart';
import 'package:flutter/material.dart';
import 'package:math_parser/math_parser.dart';

import 'package:chemical_engineering_calculator/feature/scientific_calculator/widgets/number_button_widget.dart';
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
          displayText: '\u00d7',
          onTap: buttonPressed,
        ),
        CalculatorButton(
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

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            padding: const EdgeInsets.only(top: 16),
            // color: Color.fromARGB(255, 255, 148, 186),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 138, 138, 138),
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
          // fixedColor: Colors.red,
          selectedItemColor: Colors.blue,
          backgroundColor: Colors.red,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Main Page',
              // backgroundColor: Colors.orange,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Calculator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_customize_rounded),
              label: 'Customize',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
          currentIndex: _currentIndex,
          // type: BottomNavigationBarType.shifting,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 129, 171),
      ),
    );
  }
}
