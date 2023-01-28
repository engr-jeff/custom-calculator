//ignore_for_file: arguments-ordering
import 'package:chemical_engineering_calculator/feature/scientific_calculator/scientific_calculator_page.dart';
import 'package:chemical_engineering_calculator/utils/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const _pages = [
    //TODO: Create pages for the other bottom navigation items
    const SizedBox(),
    const ScientificCalculatorPage(),
    const SizedBox(),
    const SizedBox(),
  ];
  const MainPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PinkTheme.buttonBackgroundColor,
        body: MainPage._pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Main Page'),
            BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculator'),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize_rounded), label: 'Customize'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.transparent,
          selectedItemColor: PinkTheme.bottomBarSelectedItemColor,
          unselectedItemColor: PinkTheme.bottomBarUnselectedItemColor,
        ),
      ),
    );
  }
}
