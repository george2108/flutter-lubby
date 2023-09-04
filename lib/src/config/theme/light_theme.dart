import 'package:flutter/material.dart';

final _canvasColor = Colors.grey[50]!;

final ThemeData customLightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.black,
    backgroundColor: _canvasColor,
    elevation: 0,
    surfaceTintColor: _canvasColor,
  ),
  inputDecorationTheme: const InputDecorationTheme().copyWith(
    contentPadding: const EdgeInsets.all(8.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
  ),
  cardTheme: const CardTheme().copyWith(
    color: const Color(0xFFEBEBEB),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  ),
  tabBarTheme: const TabBarTheme().copyWith(
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey,
  ),
);
