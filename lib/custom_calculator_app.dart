import 'package:chemical_engineering_calculator/feature/scientific_calculator/scientific_calculator_page.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class CustomCalculatorApp extends StatelessWidget {
  const CustomCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ScientificCalculatorPage(title: 'CUSTOM CALCULATOR'),
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorButton extends StatefulWidget {
  const CalculatorButton({
    Key? key,
    this.textCode,
    required this.displayText,
    required this.onTap,
  }) : super(key: key);

  final String? textCode;
  final String displayText;
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
        child: Listener(
          onPointerDown: (_) => setState(() => isPressed = true),
          onPointerUp: (_) => setState(() => isPressed = false),
          child: AnimatedContainer(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFF78AB),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF783A9),
                  offset: distance,
                  blurRadius: blur,
                  inset: isPressed,
                ),
                BoxShadow(
                  color: const Color(0xFFFC649B),
                  offset: distance,
                  blurRadius: blur,
                  inset: isPressed,
                ),
              ],
            ),
            height: 40,
            child: Text(
              widget.displayText,
              style: TextStyle(
                color: const Color(0xFF000000).withOpacity(0.8),
                fontSize: 17.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 75),
          ),
        ),
        onTap: () => widget.onTap(widget.textCode ?? widget.displayText),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
