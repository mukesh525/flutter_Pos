// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuResponseAdapter extends TypeAdapter<MenuResponse> {
  @override
  final int typeId = 10;

  @override
  MenuResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuResponse(
      status: fields[0] as int?,
      result: fields[1] as Result?,
    );
  }

  @override
  void write(BinaryWriter writer, MenuResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultAdapter extends TypeAdapter<Result> {
  @override
  final int typeId = 11;

  @override
  Result read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Result(
      discount: fields[0] as int?,
      banners: (fields[1] as List?)?.cast<dynamic>(),
      language: fields[2] as String?,
      categories: (fields[3] as List?)?.cast<Category>(),
      categoryPath: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Result obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.discount)
      ..writeByte(1)
      ..write(obj.banners)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.categories)
      ..writeByte(4)
      ..write(obj.categoryPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 12;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      id: fields[0] as String?,
      name: fields[1] as String?,
      icon: fields[2] as String?,
      menuType: fields[3] as String?,
      position: fields[4] as int?,
      imageBig: fields[5] as String?,
      imageSm: fields[6] as String?,
      groups: (fields[7] as List?)?.cast<Group>(),
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.menuType)
      ..writeByte(4)
      ..write(obj.position)
      ..writeByte(5)
      ..write(obj.imageBig)
      ..writeByte(6)
      ..write(obj.imageSm)
      ..writeByte(7)
      ..write(obj.groups);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GroupAdapter extends TypeAdapter<Group> {
  @override
  final int typeId = 13;

  @override
  Group read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Group(
      name: fields[0] as String?,
      description: fields[1] as String?,
      id: fields[2] as String?,
      position: fields[3] as int?,
      items: (fields[4] as List?)?.cast<Item>(),
    );
  }

  @override
  void write(BinaryWriter writer, Group obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.position)
      ..writeByte(4)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 14;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      id: fields[0] as String?,
      name: fields[1] as String?,
      dName: fields[2] as String?,
      description: fields[3] as String?,
      price: fields[4] as String?,
      discount: fields[5] as int?,
      taxRate: fields[6] as int?,
      feedbackType: fields[7] as int?,
      rating: fields[8] as String?,
      allergens: (fields[9] as List?)?.cast<String>(),
      hasAddons: fields[10] as bool?,
      isActive: fields[11] as bool?,
      images: (fields[12] as List?)?.cast<ImageInfo>(),
      activeOn: (fields[13] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dName)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.discount)
      ..writeByte(6)
      ..write(obj.taxRate)
      ..writeByte(7)
      ..write(obj.feedbackType)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.allergens)
      ..writeByte(10)
      ..write(obj.hasAddons)
      ..writeByte(11)
      ..write(obj.isActive)
      ..writeByte(12)
      ..write(obj.images)
      ..writeByte(13)
      ..write(obj.activeOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImageInfoAdapter extends TypeAdapter<ImageInfo> {
  @override
  final int typeId = 15;

  @override
  ImageInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageInfo(
      url: fields[0] as String,
      height: fields[1] as int,
      width: fields[2] as int,
      thumbnail: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageInfo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.width)
      ..writeByte(3)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
