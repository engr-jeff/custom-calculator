import 'package:chemical_engineering_calculator/custom_calculator_app.dart';
import 'package:chemical_engineering_calculator/enums/digit.dart';
import 'package:flutter/material.dart';

class NumberButtonWidget extends StatelessWidget {
  const NumberButtonWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        FourthNumbersRow(onTap),
        ThirdNumbersRow(onTap),
        SecondNumbersRow(onTap),
        FirstNumbersRow(onTap),
      ],
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    );
  }

  //TODO: use class widget
  TableRow FourthNumbersRow(void Function(String) onTap) => TableRow(
        children: [
          CalculatorButton(
            displayText: Digit.SEVEN.displayString,
            onTap: onTap,
          ),
          CalculatorButton(
            displayText: Digit.EIGHT.displayString,
            onTap: onTap,
          ),
          CalculatorButton(
            displayText: Digit.NINE.displayString,
            onTap: onTap,
          ),
        ],
      );

  TableRow ThirdNumbersRow(void Function(String) onTap) => TableRow(
        children: [
          CalculatorButton(
            displayText: Digit.FOUR.displayString,
            onTap: onTap,
          ),
          CalculatorButton(
            displayText: Digit.FIVE.displayString,
            onTap: onTap,
          ),
          CalculatorButton(
            displayText: Digit.SIX.displayString,
            onTap: onTap,
          ),
        ],
      );

  TableRow SecondNumbersRow(void Function(String) onTap) => TableRow(
        children: [
          CalculatorButton(
            displayText: Digit.ONE.displayString,
            onTap: onTap,
          ),
          CalculatorButton(
            displayText: Digit.TWO.displayString,
            onTap: onTap,
          ),
          CalculatorButton(
            displayText: Digit.THREE.displayString,
            onTap: onTap,
          ),
        ],
      );

  TableRow FirstNumbersRow(void Function(String) onTap) => TableRow(
        children: [
          CalculatorButton(
            displayText: Digit.ZERO.displayString,
            onTap: onTap,
          ),
          CalculatorButton(
            displayText: '.',
            onTap: onTap,
          ),
          CalculatorButton(
            textCode: '* 10^',
            displayText: 'x10^',
            onTap: onTap,
          ),
        ],
      );
}
