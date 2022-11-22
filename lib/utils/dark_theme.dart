import 'package:flutter/material.dart';

final Color _canvasColor = Colors.grey[850]!;

final ThemeData customDarkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: _canvasColor,
  ),
);
