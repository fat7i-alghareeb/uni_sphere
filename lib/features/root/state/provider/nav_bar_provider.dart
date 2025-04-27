import 'package:flutter/material.dart';

class NavBarProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeSelected(int index) {
    if (_selectedIndex == index) return;

    _selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
