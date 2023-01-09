import 'package:flutter/material.dart';

enum ListaDeCategorias {
  tecnologia,
}

class CategoryIcons {
  String category;
  IconData icon;

  CategoryIcons({
    required this.category,
    required this.icon,
  });
}

List<CategoryIcons> listCategoriesIcons = [
  // tecnologia

  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.computer,
  ),
  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.desktop_windows,
  ),
  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.device_hub,
  ),
  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.devices_other,
  ),
  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.dock,
  ),
  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.gamepad,
  ),
  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.headset,
  ),
  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.keyboard,
  ),
  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.keyboard_arrow_down,
  ),
  CategoryIcons(
    category: ListaDeCategorias.tecnologia.toString(),
    icon: Icons.keyboard_arrow_left,
  ),
];
