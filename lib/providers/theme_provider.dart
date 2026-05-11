import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ThemeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final theme = await _apiService.getSetting('theme');
      if (theme != null) {
        _themeMode = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading theme: $e');
    }
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    try {
      await _apiService.updateSetting('theme', _themeMode == ThemeMode.light ? 'light' : 'dark');
    } catch (e) {
      print('Error saving theme: $e');
    }
  }
}
