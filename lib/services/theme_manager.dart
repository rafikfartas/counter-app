import 'dart:developer';
import 'dart:ui';

import 'package:counter_app/services/storage_manager.dart';
import 'package:counter_app/theme/palette.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  final lightTheme = ThemeData(
    primarySwatch: Palette.kToDark,
    primaryColor: Palette.kToDark,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    accentColor: Colors.black,
    accentIconTheme: const IconThemeData(color: Colors.white),
    iconTheme: const IconThemeData(color: Palette.kToDark),
    dividerColor: Colors.white54,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Palette.kToDark,
      elevation: 0,
      // iconTheme: IconThemeData(color: Palette.kToDark),
    ),
  );

  final darkTheme = ThemeData(
    primarySwatch: Palette.white,
    primaryColor: Palette.white,
    brightness: Brightness.dark,
    backgroundColor: Palette.kToDark.shade200,
    scaffoldBackgroundColor: Palette.kToDark.shade200,
    accentColor: Colors.white,
    accentIconTheme: const IconThemeData(color: Palette.kToDark),
    iconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.black12,
    appBarTheme: AppBarTheme(
      backgroundColor: Palette.kToDark.shade200,
      elevation: 0,
    ),
  );

  late ThemeData _themeData;
  ThemeData get getTheme => _themeData;

  ThemeNotifier() {
    _themeData = lightTheme;
    StorageManager.readData('themeMode').then((value) {
      log('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        log('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
