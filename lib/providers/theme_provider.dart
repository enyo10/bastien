import 'package:bastien/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    print(" DarkTheme $_darkTheme");
    notifyListeners();
  }
}