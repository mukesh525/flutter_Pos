import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mynu/manage_table/Utils.dart';
import 'package:mynu/manage_table/servies/socket_manager.dart';
import '../../manage_order/manage_order.dart';
import 'model.dart';
import 'service.dart';
import 'package:mynu/manage_table/servies/model.dart' as TableModel;

class TableProvider extends ChangeNotifier {
  final TableService _tableService = TableService();

  final SocketManager _socketManager = SocketManager();
  List<TableGroup> tableGroup = [];
  int selectedItem = 1;

  // TableService get tableService => _tableService;

  TableProvider() {
    _socketManager.initializeSocket();
    fetchTableGroup(selectedItem);
  }

  Future<void> fetchTableGroup(index) async {
    selectedItem = index;
    tableGroup.clear();
    tableGroup = await _tableService.fetchDataFromUrl();
    print("tableGroup  size ${tableGroup.length}");
    notifyListeners();
    listenForSocketEvent();
  }

  void listenForSocketEvent() {
    _socketManager.socket
        .emit("join", {"restaurantId": "5d68ad588085a04652357431"});
    _socketManager.socket.on('table.sync', (data) {
      if (data is List && data.isNotEmpty) {
        for (var tableData in data[0]["tables"]) {
          final String tableId = tableData['id'];
          final int newStatus = tableData['status'];
          final int groupId = tableData['groupId'];
          print('Table ID: $tableId, Status: $newStatus, Group ID: $groupId');

          final int existingTableGroupIndex = tableGroup.indexWhere(
            (existingTableGroup) => existingTableGroup.id == groupId,
          );

          if (existingTableGroupIndex != -1) {
            final List<TableModel.Table> existingTables =
                tableGroup[existingTableGroupIndex].tables;

            final int existingTableIndex = existingTables
                .indexWhere((existingTable) => existingTable.id == tableId);

            if (existingTableIndex != -1) {
              // Update existing table status
              tableGroup[existingTableGroupIndex]
                  .tables[existingTableIndex]
                  .status = newStatus;
            }
          }
        }
      }

      notifyListeners();
      // Handle the socket event data as needed
    });
    _socketManager.socket.on('table.update', (data) {
      if (data is List && data.length > 0) {
        // final jsonData = json.decode(data[0]);
        String action = data[0]["action"];
        int timestamp = data[0]["timestamp"];
        int status = data[0]["status"];
        print(
            'Socket event table.update received in TableProvider: ${action} ${timestamp} ${status}');
        notifyListeners();
      }
      // Handle the socket event data as needed
    });
  }

  void navigateToTable(BuildContext context, String item) {
    // Listen for socket events in the provider
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ManageOrderScreen()));
  }
}
