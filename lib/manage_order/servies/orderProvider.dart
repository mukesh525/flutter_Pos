import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'category_model.dart';
import 'service.dart';

class OrderProvider extends ChangeNotifier {
  TableService _tableService = TableService();
  List<ModelCategory> _categories = [
    ModelCategory(
        name: 'Fast Food',
        icon: Icons.category,
        color: Colors.green,
        menuItems: [
          'Beverages',
          'Burger',
          'Egg',
          'Chicken',
          'Chakhna',
          'Chinese',
          'Snacks',
          'Soup',
          'Garlic Bread'
        ],
        isExpanded: true),
    ModelCategory(
        name: 'Beverages',
        icon: Icons.category,
        color: Colors.green,
        menuItems: ['Item 3', 'Item 4'],
        isExpanded: false),
    ModelCategory(
        name: 'Burger',
        icon: Icons.category,
        color: Colors.green,
        menuItems: ['Item 3', 'Item 4'],
        isExpanded: false),
    ModelCategory(
        name: 'EGG',
        icon: Icons.category,
        color: Colors.green,
        menuItems: ['Item 3', 'Item 4'],
        isExpanded: false),
    // Add more categories with their respective menu items
  ];

  List<ModelCategory> get categories => _categories;

  int selectedItem = 1;

  TableService get tableService => _tableService;

  OrderProvider() {
    fetchTableData(selectedItem);
  }

  int _selectedCategoryIndex = -1; // Initialize with an invalid index

  int get selectedCategoryIndex => _selectedCategoryIndex;

  void setSelectedCategory(int index) {
    if (_selectedCategoryIndex == index) {
      // If it's the same category, deselect it
      _selectedCategoryIndex = -1;
    } else {
      // If it's a different category, select it
      _selectedCategoryIndex = index;
    }

    // Notify listeners to rebuild UI
    notifyListeners();
  }

  Map<int, int> selectedMenuItems = {};

  void setSelectedMenuItem(int categoryIndex, int menuItemIndex) {
    // Clear the selection for the previous category
    selectedMenuItems.removeWhere((key, value) => key != categoryIndex);
    // Set the selected menu item index for the current category
    selectedMenuItems[categoryIndex] = menuItemIndex;
    notifyListeners();
  }

  void toggleCategoryExpansion(int categoryIndex) {
    _categories[categoryIndex].isExpanded =
        !_categories[categoryIndex].isExpanded;
    notifyListeners();
  }

  Future<void> fetchTableData(index) async {
    // categories = _tableService.fetchCategoryData();
    notifyListeners();
  }
}
