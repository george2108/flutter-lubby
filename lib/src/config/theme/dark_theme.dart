import 'package:flutter/material.dart';

final Color _canvasColor = Colors.grey[850]!;

final ThemeData customDarkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: _canvasColor,
  ),
  inputDecorationTheme: const InputDecorationTheme().copyWith(
    contentPadding: const EdgeInsets.all(8.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
    showUnselectedLabels: false,
  ),
);
