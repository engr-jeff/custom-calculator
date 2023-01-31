import 'package:chemical_engineering_calculator/classes/calculator_handler.dart';
import 'package:chemical_engineering_calculator/custom_calculator_app.dart';
import 'package:chemical_engineering_calculator/feature/main_page/widgets/number_button_widget.dart';
import 'package:chemical_engineering_calculator/utils/theme.dart';
import 'package:flutter/material.dart';

class ScientificCalculatorPage extends StatefulWidget {
  const ScientificCalculatorPage({super.key});

  @override
  State<ScientificCalculatorPage> createState() => _ScientificCalculatorPageState();
}

class _ScientificCalculatorPageState extends State<ScientificCalculatorPage> {
  late CalculatorHandler calculator;
  // String resultText = '0';
  // String displayText = '0';
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    calculator = CalculatorHandler();
  }

  void onTapButtons(String input) {
    setState(() {
      calculator.writeToDisplay(input);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final fourthBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          displayText: 'DEL',
          onTap: onTapButtons,
        ),
        CalculatorButton(
          displayText: 'AC',
          textCode: 'AC',
          onTap: onTapButtons,
        ),
      ],
    );

    final thirdBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          textCode: '*',
          displayText: '\u00d7',
          onTap: onTapButtons,
        ),
        CalculatorButton(
          textCode: '/',
          displayText: '÷',
          onTap: onTapButtons,
        ),
      ],
    );

    final SecondBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          displayText: '+',
          onTap: onTapButtons,
        ),
        // Minus sign (longer than default - string)
        CalculatorButton(
          textCode: '-',
          displayText: '\u2212',
          onTap: onTapButtons,
        ),
      ],
    );

    final FirstBasicFunctionsRow = TableRow(
      children: [
        CalculatorButton(
          displayText: 'Ans',
          onTap: onTapButtons,
        ),
        CalculatorButton(
          displayText: '=',
          onTap: onTapButtons,
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
                child: Text(
                  calculator.displayText,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: screenSize.width,
                child: Text(
                  calculator.resultText,
                  style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w600),
                ),
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
                child: NumberButtonWidget(onTap: onTapButtons),
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
                child: NumberButtonWidget(onTap: onTapButtons),
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
