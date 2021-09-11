import 'package:flutter/material.dart';

class ThemesLubby {
  final darkThemeLubby = ThemeData.dark().copyWith(
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),
  );
}
