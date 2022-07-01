import 'package:flutter/material.dart';
import 'package:lubby_app/services/shared_preferences_service.dart';

class ConfigAppProvider with ChangeNotifier {
  late ThemeMode _themeMode;
  late SharedPreferencesService prefs;

  ConfigAppProvider() {
    print('inicia constructor');
    prefs = SharedPreferencesService();
    _themeMode = prefs.tema == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  changeTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  set themeMode(ThemeMode themeMode) {
    this._themeMode = themeMode;
    notifyListeners();
  }
}
