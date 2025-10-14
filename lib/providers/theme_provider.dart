import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visand/config/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;
  bool _isDark = false;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData get theme => _themeData;
  bool get isDark => _isDark;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    _isDark = theme == AppTheme.darkTheme;
    _saveTheme();
    notifyListeners();
  }

  void toggleTheme() {
    setTheme(_isDark ? AppTheme.lightTheme : AppTheme.darkTheme);
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_dark', _isDark);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('is_dark') ?? false;
    _themeData = _isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
    notifyListeners();
  }
}
