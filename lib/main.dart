import 'package:chemical_engineering_calculator/custom_calculator_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(const CustomCalculatorApp());
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
}
