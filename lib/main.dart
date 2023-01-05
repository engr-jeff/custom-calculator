import 'package:chemical_engineering_calculator/feature/scientific_calculator/scientific_calculator_page.dart';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ScientificCalculatorPage(title: 'CHE CALCULATOR'),
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorButton extends StatefulWidget {
  const CalculatorButton({
    Key? key,
    required this.displayText,
    required this.textCode,
    required this.onTap,
  }) : super(key: key);

  final String displayText;
  final String textCode;
  final void Function(String number) onTap;

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed ? const Offset(3, 3) : const Offset(0, 0);
    double blur = isPressed ? 10 : 2;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: InkWell(
        onTap: () => widget.onTap(widget.displayText),
        borderRadius: BorderRadius.circular(10),
        child: Listener(
          onPointerDown: (_) => setState(() => isPressed = true),
          onPointerUp: (_) => setState(() => isPressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 75),
            curve: Curves.decelerate,
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 255, 120, 171),
              boxShadow: [
                BoxShadow(
                  inset: isPressed,
                  color: const Color.fromARGB(255, 247, 131, 169),
                  offset: distance,
                  blurRadius: blur,
                ),
                BoxShadow(
                  inset: isPressed,
                  color: const Color.fromARGB(255, 252, 100, 155),
                  offset: distance,
                  blurRadius: blur,
                ),
              ],
            ),
            child: Text(
              widget.displayText,
              style: TextStyle(
                fontSize: 17.5,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
