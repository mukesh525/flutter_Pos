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
  Map<String, int> tableIds = {};
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

  void updateValue(int i, int j, int newValue) {
    final key = "$i-$j";
    tableIds[key] = newValue;
  }

  void listenForSocketEvent() {
    _socketManager.socket
        .emit("join", {"restaurantId": "5d68ad588085a04652357431"});

    _socketManager.socket.on('table.sync', updateSocketPayload);
    _socketManager.socket.on('table.update', (data) {
      if (data is List && data.isNotEmpty) {
        tableIds = {};
        String tableId = data[0]["tableId"];
        int newStatus = data[0]["status"];
        int groupId = data[0]["groupId"];

        final int existingTableGroupIndex = tableGroup.indexWhere(
          (existingTableGroup) => existingTableGroup.id == groupId,
        );

        if (existingTableGroupIndex != -1) {
          final int existingTableIndex = tableGroup[existingTableGroupIndex]
              .tables
              .indexWhere((existingTable) => existingTable.id == tableId);

          updateValue(existingTableGroupIndex, existingTableIndex, newStatus);
        }

        updateTableStatus();
      }
    });
  }

  void updateSocketPayload(data) {
    if (data is List && data.isNotEmpty) {
      tableIds = {};
      for (var tableData in data[0]["tables"]) {
        final String tableId = tableData['id'];
        final int newStatus = tableData['status'];
        final int groupId = tableData['groupId'];

        final int existingTableGroupIndex = tableGroup.indexWhere(
          (existingTableGroup) => existingTableGroup.id == groupId,
        );

        if (existingTableGroupIndex != -1) {
          final int existingTableIndex = tableGroup[existingTableGroupIndex]
              .tables
              .indexWhere((existingTable) => existingTable.id == tableId);

          updateValue(existingTableGroupIndex, existingTableIndex, newStatus);
        }
      }

      updateTableStatus();
    }
  }

  void updateTable(tableId, groupId, newStatus) {
    final int existingTableGroupIndex = tableGroup.indexWhere(
      (existingTableGroup) => existingTableGroup.id == groupId,
    );

    if (existingTableGroupIndex != -1) {
      final int existingTableIndex = tableGroup[existingTableGroupIndex]
          .tables
          .indexWhere((existingTable) => existingTable.id == tableId);

      updateValue(existingTableGroupIndex, existingTableIndex, newStatus);
      updateTableStatus();
    }
  }

  void updateTableStatus() {
    for (int i = 0; i < tableGroup.length; i++) {
      for (int j = 0; j < tableGroup[i].tables.length; j++) {
        final key = "$i-$j";

        tableGroup[i].tables[j].status = tableIds.containsKey(key)
            ? tableIds[key]!
            : tableGroup[i].tables[j].status;
      }
    }

    notifyListeners();
  }

  void navigateToTable(BuildContext context, String item) {
    // Listen for socket events in the provider
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ManageOrderScreen()));
  }
}
