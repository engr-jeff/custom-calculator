import 'package:chemical_engineering_calculator/main.dart';
import 'package:chemical_engineering_calculator/utils/constants.dart';
import 'package:flutter/material.dart';

class NumberButtonWidget extends StatelessWidget {
  const NumberButtonWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    final FourthNumbersRow = TableRow(
      children: [
        CalculatorButton(
          textCode: '7',
          displayText: Number.SEVEN.displayString,
          onTap: onTap,
        ),
        CalculatorButton(
          textCode: '8',
          displayText: Number.EIGHT.displayString,
          onTap: onTap,
        ),
        CalculatorButton(
          textCode: '9',
          displayText: Number.NINE.displayString,
          onTap: onTap,
        ),
      ],
    );

    final ThirdNumbersRow = TableRow(
      children: [
        CalculatorButton(
          textCode: '4',
          displayText: Number.FOUR.displayString,
          onTap: onTap,
        ),
        CalculatorButton(
          textCode: '5',
          displayText: Number.FIVE.displayString,
          onTap: onTap,
        ),
        CalculatorButton(
          textCode: '6',
          displayText: Number.SIX.displayString,
          onTap: onTap,
        ),
      ],
    );

    final SecondNumbersRow = TableRow(
      children: [
        CalculatorButton(
          textCode: '1',
          displayText: Number.ONE.displayString,
          onTap: onTap,
        ),
        CalculatorButton(
          textCode: '2',
          displayText: Number.TWO.displayString,
          onTap: onTap,
        ),
        CalculatorButton(
          textCode: '3',
          displayText: Number.THREE.displayString,
          onTap: onTap,
        ),
      ],
    );

    final FirstNumbersRow = TableRow(
      children: [
        CalculatorButton(
          textCode: '0',
          displayText: Number.ZERO.displayString,
          onTap: onTap,
        ),
        CalculatorButton(
          textCode: '.',
          displayText: '.',
          onTap: onTap,
        ),
        CalculatorButton(
          textCode: 'x10^',
          displayText: 'x10^',
          onTap: onTap,
        ),
      ],
    );

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        FourthNumbersRow,
        ThirdNumbersRow,
        SecondNumbersRow,
        FirstNumbersRow,
      ],
    );
  }
}