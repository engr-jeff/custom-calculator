import 'package:chemical_engineering_calculator/feature/main_page/main_page.dart';
import 'package:chemical_engineering_calculator/utils/theme.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class CustomCalculatorApp extends StatelessWidget {
  const CustomCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(title: 'CUSTOM CALCULATOR'),
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
    Offset distance = isPressed ? const Offset(4, 4) : const Offset(0, 0);
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
              color: PinkTheme.buttonColor,
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
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    offset: Offset(0, 0.25),
                    blurRadius: 0.25,
                  ),
                ],
                fontFamily: 'ShareTechMono',
              ),
            ),
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 100),
          ),
        ),
        onTap: () => widget.onTap(widget.textCode ?? widget.displayText),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
