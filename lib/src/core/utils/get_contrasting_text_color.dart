import 'package:flutter/material.dart';

Color getContrastingTextColor(Color backgroundColor) {
  // Calcula la luminancia del color de fondo
  final luminance = (0.299 * backgroundColor.red +
          0.587 * backgroundColor.green +
          0.114 * backgroundColor.blue) /
      255;

  // Si el color de fondo es oscuro, devuelve un color de texto claro, de lo contrario, devuelve un color de texto oscuro.
  return luminance > 0.5 ? Colors.black : Colors.white;
}
