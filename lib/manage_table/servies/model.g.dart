// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableGroupAdapter extends TypeAdapter<TableGroup> {
  @override
  final int typeId = 0;

  @override
  TableGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableGroup(
      id: fields[0] as int,
      name: fields[1] as String,
      tables: (fields[2] as List).cast<Table>(),
    );
  }

  @override
  void write(BinaryWriter writer, TableGroup obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.tables);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TableAdapter extends TypeAdapter<Table> {
  @override
  final int typeId = 1;

  @override
  Table read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Table(
      id: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Table obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
