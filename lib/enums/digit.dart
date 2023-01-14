import 'package:flutter/foundation.dart';

enum Digit {
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

extension Value on Digit {
  String get value => describeEnum(this);

  String get displayString {
    switch (this) {
      case Digit.ZERO:
        return '0';
      case Digit.ONE:
        return '1';
      case Digit.TWO:
        return '2';
      case Digit.THREE:
        return '3';
      case Digit.FOUR:
        return '4';
      case Digit.FIVE:
        return '5';
      case Digit.SIX:
        return '6';
      case Digit.SEVEN:
        return '7';
      case Digit.EIGHT:
        return '8';
      case Digit.NINE:
        return '9';
      default:
        return '';
    }
  }
}
