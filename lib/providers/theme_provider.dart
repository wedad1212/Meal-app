import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode tm = ThemeMode.light;

  // to save SharedPreferences
  String themeText = '';

  var primaryColor = Colors.red;
  var accentColor = Colors.amber;

  void changeThemeMode(newThemeMode) async {
    tm = newThemeMode;
    _themeText(tm);
    notifyListeners();
    SharedPreferences prfs = await SharedPreferences.getInstance();
    prfs.setString('themeMode', themeText);
  }

  void setColors(n, Color newColor) async {
    n == 1
        ? primaryColor = _convertToMaterialColor(newColor.value)
        : accentColor = _convertToMaterialColor(newColor.value);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primary', primaryColor.value);
    prefs.setInt('accent', accentColor.value);

    notifyListeners();
  }

  _convertToMaterialColor(color) {
    return MaterialColor(color, <int, Color>{
      50: const Color(0xFFFFEBEE),
      100: const Color(0xFFFFCDD2),
      200: const Color(0xFFEF9A9A),
      300: const Color(0xFFE57373),
      400: const Color(0xFFEF5350),
      500: Color(color),
      600: const Color(0xFFE53935),
      700: const Color(0xFFD32F2F),
      800: const Color(0xFFC62828),
      900: const Color(0xFFB71C1C),
    });
  }

  _themeText(ThemeMode tm) {
    if (tm == ThemeMode.light) {
      themeText = 'l';
    } else if (tm == ThemeMode.dark) {
      themeText = 'd';
    }
  }

  getTheme() async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    themeText = prfs.getString('themeMode') ?? 'l';
    if (themeText == 'l') {
      tm = ThemeMode.light;
    } else if (themeText == 'd') {
      tm = ThemeMode.dark;
    }
    primaryColor =
        _convertToMaterialColor(prfs.getInt('primary') ?? 0xFFF44336);
    accentColor = _convertToMaterialColor(prfs.getInt('accent') ?? 0xFFFFC107);
    notifyListeners();
  }
}
