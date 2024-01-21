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
  orderReady,
  attenion,
  billing,
  idle,
}

class TableStatusMapping {
  static const Map<TableStatus, Color> statusLabels = {
    TableStatus.orderReady: Colors.lightGreen,
    TableStatus.attenion: Colors.orangeAccent,
    TableStatus.billing: Colors.redAccent,
    TableStatus.idle: Colors.white60,
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
