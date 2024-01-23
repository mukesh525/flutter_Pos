import 'package:hive/hive.dart';

part 'menu_model.g.dart';

@HiveType(typeId: 10)
class MenuResponse {
  @HiveField(0)
  int? status;

  @HiveField(1)
  Result? result;

  MenuResponse({
    this.status,
    this.result,
  });

  factory MenuResponse.fromJson(Map<String, dynamic> json) {
    return MenuResponse(
      status: json['status'],
      result: Result.fromJson(json['result']),
    );
  }
}

@HiveType(typeId: 11)
class Result {
  @HiveField(0)
  int? discount;

  @HiveField(1)
  List<dynamic>? banners;

  @HiveField(2)
  String? language;

  @HiveField(3)
  List<Category>? categories;

  @HiveField(4)
  String? categoryPath;

  Result({
    this.discount,
    this.banners,
    this.language,
    this.categories,
    this.categoryPath,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      discount: json['discount'],
      banners: json['banners'],
      language: json['language'],
      categories: List<Category>.from(
          json['categories'].map((category) => Category.fromJson(category))),
      categoryPath: json['categoryPath'],
    );
  }
}

@HiveType(typeId: 12)
class Category {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? icon;

  @HiveField(3)
  String? menuType;

  @HiveField(4)
  int? position;

  @HiveField(5)
  String? imageBig;

  @HiveField(6)
  String? imageSm;

  @HiveField(7)
  List<Group>? groups;
  bool isExpanded = false;

  Category({
    this.id,
    this.name,
    this.icon,
    this.menuType,
    this.position,
    this.imageBig,
    this.imageSm,
    this.groups,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      icon: json['icon'],
      menuType: json['menuType'],
      //position: json['position'],
      imageBig: json['image_big'],
      imageSm: json['image_sm'],
      groups: json['groups'] != null
          ? List<Group>.from(
              json['groups'].map((group) => Group.fromJson(group)))
          : [],
    );
  }
}

@HiveType(typeId: 13)
class Group {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? id;

  @HiveField(3)
  int? position;

  @HiveField(4)
  List<Item>? items;

  Group({
    this.name,
    this.description,
    this.id,
    this.position,
    this.items,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json['name'],
      description: json['description'],
      id: json['_id'],
      position: json['position'],
      items: json['items'] != null
          ? List<Item>.from(json['items'].map((item) => Item.fromJson(item)))
          : [],
    );
  }
}

@HiveType(typeId: 14)
class Item {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? dName;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? price = '1.5';

  @HiveField(5)
  int? discount;

  @HiveField(6)
  int? taxRate;

  @HiveField(7)
  int? feedbackType;

  @HiveField(8)
  String? rating;

  @HiveField(9)
  List<String>? allergens;

  @HiveField(10)
  bool? hasAddons;

  @HiveField(11)
  bool? isActive;

  @HiveField(12)
  List<ImageInfo>? images;

  @HiveField(13)
  Map<String, dynamic>? activeOn;

  Item({
    this.id,
    this.name,
    this.dName,
    this.description,
    this.price,
    this.discount,
    this.taxRate,
    this.feedbackType,
    this.rating,
    this.allergens,
    this.hasAddons,
    this.isActive,
    this.images,
    this.activeOn,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    print(json['Name']);

    return Item(
      id: json['_id'],
      name: json['name'],
      dName: json['dName'],
      description: json['description'],
      price: json['price'] !=null ?json['price'].toString():'0.0',
      discount: json['discount'] is int ? json['discount'] : 0,
      taxRate: json['taxRate'] is int ? json['taxRate'] : 0,
      feedbackType: json['feedbackType'] is int ? json['feedbackType'] : 0,
      rating: json['rating'] is double ? json['rating'].toString() : '0.0',
      allergens:
          json['allergens'] == null ? [] : List<String>.from(json['allergens']),
      hasAddons: json['hasAddons'] is bool ? json['hasAddons'] : false,
      isActive: json['isActive'] is bool ? json['isActive'] : false,
      images: json['images'] != null
          ? List<ImageInfo>.from(
              json['images'].map((item) => ImageInfo.fromJson(item)))
          : [],
      activeOn: json['activeOn'],
    );
  }
}

@HiveType(typeId: 15)
class ImageInfo extends HiveObject {
  @HiveField(0)
  final String url;

  @HiveField(1)
  final int height;

  @HiveField(2)
  final int width;

  @HiveField(3)
  final String thumbnail;

  ImageInfo({
    required this.url,
    required this.height,
    required this.width,
    required this.thumbnail,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      url: json['url'],
      // height: json['height'],
      // width: json['width'],
      height: 0,
      width: 0,
      thumbnail: json['thumbnail'],
    );
  }
}
