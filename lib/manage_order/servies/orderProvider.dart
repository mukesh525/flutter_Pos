import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mynu/manage_order/servies/menu_model.dart' as MenuModel;

import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import '../OrderScreen.dart';
import 'hive_service.dart';
import 'menu_model.dart';
import 'orderModel.dart';
import 'service.dart';

class OrderProvider extends ChangeNotifier {
  TableService _tableService = TableService();
  final HiveService _hiveService = HiveService();
  List<MenuModel.Category> categories = [];

  List<Item> _menuItems = [];
  int? expandedCategoryIndex = 0;
  List<OrderItem> _orderItems = [
    // Add more dummy items as needed
  ];

  List<OrderItem> get orderItems => _orderItems;

  List<Item> get menuItems => _menuItems;

  Future<bool> isHiveEmpty() async {
    final box = await Hive.openBox<List<MenuModel.Category>>('menuBox');
    final isEmpty = box.isEmpty;
    await box.close();
    return isEmpty;
  }

  Future<void> fetchData() async {
    final _isHiveEmpty = await isHiveEmpty();
    if (_isHiveEmpty) {
      try {
        //await Hive.box('menu_response').clear();
        MenuResponse response = await _tableService.fetchDataFromUrl();
        await _hiveService.saveMenuResponseToHive(response);
        categories = response.result!.categories!;
      } catch (e) {
        print('Error fetching data from API: $e');
      }
    } else {
      MenuResponse response = await _hiveService.getSavedMenuResponseFromHive();
      categories = response.result!.categories!;
    }

    categories[0].isExpanded = true;
    setSelectedMenuItem(0, 0);

    notifyListeners();
  }

  void addItem(OrderItem item) {
    bool itemExists = _orderItems.any((_item) => _item.name == item.name);
    if (!itemExists) {
      _orderItems.add(item);
    } else {
      int index =
          _orderItems.indexWhere((element) => element.name == item.name);
      if (index != -1) {
        _orderItems[index].quantity = _orderItems[index].quantity + 1;
      }
    }
    notifyListeners();
  }

  void reduceQuantity(OrderItem item) {
    int index = _orderItems.indexWhere((element) => element.name == item.name);

    if (index != -1) {
      _orderItems[index].quantity = _orderItems[index].quantity - 1;

      if (_orderItems[index].quantity <= 0) {
        _orderItems.removeAt(index);
      }

      notifyListeners();
    }
  }

  void addQuantity(OrderItem item) {
    int index = _orderItems.indexWhere((element) => element.name == item.name);

    if (index != -1) {
      _orderItems[index].quantity = _orderItems[index].quantity + 1;
      notifyListeners();
    }
  }

  void updateItemQuantity(OrderItem item) {
    bool itemExists = _orderItems.any((_item) => _item.name == item.name);
    // if (itemExists) {
    //   _orderItems.add(itemExists);
    //   notifyListeners();
    // }
  }

  void removeItem(OrderItem item) {
    _orderItems.remove(item);
    notifyListeners();
  }

  void clearOrder() {
    _orderItems.clear();
    notifyListeners();
  }

  int selectedItem = 1;

  TableService get tableService => _tableService;

  OrderProvider() {
    fetchTableData(selectedItem);
    fetchData();
  }

  int _selectedCategoryIndex = -1; // Initialize with an invalid index

  int get selectedCategoryIndex => _selectedCategoryIndex;

  void setSelectedCategory(int cat_index) {
    if (_selectedCategoryIndex == cat_index) {
      // If it's the same category, deselect it
      _selectedCategoryIndex = -1;
    } else {
      // If it's a different category, select it
      _selectedCategoryIndex = cat_index;
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

    _menuItems = categories[categoryIndex].groups![menuItemIndex].items!;
    print(_menuItems);

    notifyListeners();
  }

  void toggleCategoryExpansion(int categoryIndex) {
    if (expandedCategoryIndex != null) {
      categories[expandedCategoryIndex!].isExpanded = false;
    }

    categories[categoryIndex].isExpanded =
        !categories[categoryIndex].isExpanded;
    expandedCategoryIndex =
        categories[categoryIndex].isExpanded ? categoryIndex : null;

    notifyListeners();
  }

  Future<void> fetchTableData(index) async {
    // categories = _tableService.fetchCategoryData();
    notifyListeners();
  }

  void printOrder() async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    final PosPrintResult res =
        await printer.connect('192.168.0.123', port: 9100);

    if (res == PosPrintResult.success) {
      printReceipt(printer, "Mynu", orderItems);
      printer.disconnect();
    }

    print('Print result: ${res.msg}');
  }

  void printReceipt(
      NetworkPrinter printer, String storeName, List<OrderItem> orderItems) {
    // Print store name
    printer.text(storeName,
        styles: PosStyles(align: PosAlign.center, bold: true));
    printer.feed(1);

    // Print order items
    for (OrderItem orderItem in orderItems) {
      printer.text(orderItem.name, styles: PosStyles(align: PosAlign.left));
      printer.text('${orderItem.quantity} x ${orderItem.price} \$',
          styles: PosStyles(align: PosAlign.left));
      printer.text('${orderItem.quantity * orderItem.price} \$',
          styles: PosStyles(align: PosAlign.left));
    }

    // Print total value with currency symbol
    double totalValue = orderItems.fold(
        0.0, (sum, item) => sum + (item.quantity * item.price).toDouble());
    printer.text('Total Value: ${totalValue.toStringAsFixed(2)} \$',
        styles: PosStyles(align: PosAlign.left));

    // Additional formatting or cutting if needed
    printer.feed(2);
    printer.cut();
  }
}
