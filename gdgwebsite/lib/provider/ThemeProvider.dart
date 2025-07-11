//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _userHasChosen = false;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system && !_userHasChosen) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

void toggleTheme() {
  final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;

  if (!_userHasChosen && _themeMode == ThemeMode.system) {
    _themeMode = brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
  } else {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  _userHasChosen = true;
  notifyListeners();
}

}
