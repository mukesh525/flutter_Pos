import 'package:hive/hive.dart';

import '../Utils.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class TableGroup {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Table> tables;


  TableGroup({required this.id, required this.name, required this.tables});

  factory TableGroup.fromJson(Map<String, dynamic> json) {
    var tablesList = json['tables'] as List;
    List<Table> tables =
        tablesList.map((table) => Table.fromJson(table)).toList();

    return TableGroup(
      id: json['id'],
      name: json['name'],
      tables: tables,
    );
  }
}

@HiveType(typeId: 1)
class Table {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  int status = 1;

  Table({required this.id, required this.name});

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      id: json['id'],
      name: json['name'],
    );
  }
}
