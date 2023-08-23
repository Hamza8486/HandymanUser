// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  HomeResponse({
    required this.statusCode,
    required  this.message,
    required this.data,
  });

  var statusCode;
  String message;
  Data data;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.category,
    required this.banner,
  });

  List<Banner> category;
  List<Banner> banner;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: List<Banner>.from(json["category"].map((x) => Banner.fromJson(x))),
    banner: List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
  };
}

class  Banner {
  Banner({
    required  this.id,
    required  this.name,
    required  this.description,
    required this.image,
    required this.banner,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required  this.parentId,
    required  this.subCategory,
  });

  int id;
  String name;
  String description;
  String image;
  String banner;
  var status;
  DateTime createdAt;
  DateTime updatedAt;
  var parentId;
  List<Banner> ? subCategory;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    name: json["name"]??"",
    description: json["description"]??"",
    image: json["image"]??"",
    banner: json["banner"] ??"",
    status: json["status"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    parentId: json["parent_id"] ??"",
    subCategory: json["subCategory"] == null ? null : List<Banner>.from(json["subCategory"].map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "banner": banner,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "parent_id": parentId ,
    "subCategory": subCategory == null ? null : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
  };
}
