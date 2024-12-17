// lib/core/providers/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  // Define two ThemeData instances for light and dark themes
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    // Define other light theme properties as needed
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    // Define other dark theme properties as needed
  );

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  // Load the theme preference from Hive
  void _loadTheme() {
    final settingsBox = Hive.box('settings');
    final isDarkMode = settingsBox.get('isDarkMode', defaultValue: false);
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Toggle the theme and save the preference to Hive
  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    final settingsBox = Hive.box('settings');
    settingsBox.put('isDarkMode', isOn);
    notifyListeners();
  }
}
