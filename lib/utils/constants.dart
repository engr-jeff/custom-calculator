import 'package:flutter/foundation.dart';

// Numbers
// ignore_for_file: prefer-static-class
const singleDigitsList = [
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
];

// Add, subtract, multiply, divide, and equal signs.
const basicOperatorsList = [' + ', ' \u00d7 ', ' \u2212 ', ' ÷ ', '='];

enum Number {
  ZERO,
  ONE,
  TWO,
  THREE,

  FOUR,
  FIVE,
  SIX,

  SEVEN,
  EIGHT,
  NINE,
}

extension getValue on Number {
  String get value => describeEnum(this);

  String get displayString {
    switch (this) {
      case Number.ZERO:
        return '0';
      case Number.ONE:
        return '1';
      case Number.TWO:
        return '2';
      case Number.THREE:
        return '3';
      case Number.FOUR:
        return '4';
      case Number.FIVE:
        return '5';
      case Number.SIX:
        return '6';
      case Number.SEVEN:
        return '7';
      case Number.EIGHT:
        return '8';
      case Number.NINE:
        return '9';
      default:
        return '';
    }
  }
}
