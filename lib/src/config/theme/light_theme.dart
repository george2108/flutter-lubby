import 'package:flutter/material.dart';

final _canvasColor = Colors.grey[50]!;

final ThemeData customLightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.black,
    backgroundColor: _canvasColor,
    elevation: 0,
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
);
