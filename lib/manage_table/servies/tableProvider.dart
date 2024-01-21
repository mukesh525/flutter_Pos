import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mynu/manage_table/servies/socket_manager.dart';
import '../../manage_order/manage_order.dart';
import 'model.dart';
import 'service.dart';

class TableProvider extends ChangeNotifier {
  final TableService _tableService = TableService();

  final SocketManager _socketManager = SocketManager();
  List<TableGroup> tableGroup = [];
  int selectedItem = 1;

  // TableService get tableService => _tableService;

  TableProvider() {
    _socketManager.initializeSocket();
    fetchTableGroup(selectedItem);
    listenForSocketEvent();
  }

  Future<void> fetchTableGroup(index) async {
    selectedItem = index;
    tableGroup.clear();
    tableGroup = await _tableService.fetchDataFromUrl();
    print("tableGroup  size ${tableGroup.length}");
    notifyListeners();
  }

  void listenForSocketEvent() {
    // Listen for socket events in the provider
    _socketManager.socket.on('yourEventName', (data) {
      print('Socket event received in TableProvider: $data');
      notifyListeners();
      // Handle the socket event data as needed
    });
  }

  void navigateToTable(BuildContext context, String item) {
    // Listen for socket events in the provider
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ManageOrderScreen()));
  }
}
