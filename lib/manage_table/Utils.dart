import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

enum TableStatus { OPEN, SCANNED, ORDERED, DISABLED, PAID }

class TableStatusMapping {
  static const Map<TableStatus, Color> statusLabels = {
    TableStatus.OPEN: Colors.white,
    TableStatus.SCANNED: Colors.yellow,
    TableStatus.ORDERED: Colors.green,
    TableStatus.DISABLED: Colors.grey,
    TableStatus.PAID: Colors.orangeAccent
  };
}

TableStatus getTableStatus(int status) {

  switch (status) {
    case 1:
      return TableStatus.OPEN;
    case 2:
      return TableStatus.SCANNED;
    case 3:
      return TableStatus.ORDERED;
    case 4:
      return TableStatus.DISABLED;
    case 5:
      return TableStatus.PAID;
    default:
      return TableStatus.OPEN;
  }
}

Color? getTableStatusColor(int status) {
  return TableStatusMapping.statusLabels[getTableStatus(status)];
}

Color? getRandomStatus() {
  final random = Random();
  List<TableStatus> allStatuses = TableStatus.values;
  TableStatus status = allStatuses[random.nextInt(allStatuses.length)];
  return TableStatusMapping.statusLabels[status];
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.white,
  minimumSize: const Size(77, 33),
  padding: const EdgeInsets.symmetric(horizontal: 2.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  backgroundColor: Colors.orangeAccent,
);
