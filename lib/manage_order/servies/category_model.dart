import 'package:flutter/material.dart';

class ModelCategory {
  final String name;
  final IconData icon;
  final Color color;
  final List<String> menuItems;
  bool isExpanded;

  ModelCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.menuItems,
    this.isExpanded = false,
  });
}
