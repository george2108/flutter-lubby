import 'package:flutter/material.dart';

final _canvasColor = Colors.grey[50]!;

final ThemeData customLightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.black,
    backgroundColor: _canvasColor,
    elevation: 0,
  ),
);
