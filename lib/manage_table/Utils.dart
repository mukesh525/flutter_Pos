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

enum TableStatus {
  OPEN,
  SCANNED,
  ORDERED,
  DISABLED,
  PAID,
}

class TableStatusMapping {
  static const Map<TableStatus, Color> statusLabels = {
    TableStatus.OPEN: Colors.white,
    TableStatus.SCANNED: Colors.yellow,
    TableStatus.ORDERED: Colors.green,
    TableStatus.DISABLED: Colors.grey,
    TableStatus.PAID: Colors.orangeAccent,
  };
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
