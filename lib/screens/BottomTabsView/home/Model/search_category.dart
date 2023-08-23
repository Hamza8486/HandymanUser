// To parse this JSON data, do
//
//     final searchCategoryModel = searchCategoryModelFromJson(jsonString);

import 'dart:convert';

SearchCategoryModel searchCategoryModelFromJson(String str) => SearchCategoryModel.fromJson(json.decode(str));

String searchCategoryModelToJson(SearchCategoryModel data) => json.encode(data.toJson());

class SearchCategoryModel {
  SearchCategoryModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<Datum> data;

  factory SearchCategoryModel.fromJson(Map<String, dynamic> json) => SearchCategoryModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required  this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.status,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
     this.subCategory,
  });

  int id;
  String name;
  String description;
  String image;
  var status;
  var parentId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Datum> ? subCategory;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"]??"",
    description: json["description"]??"",
    image: json["image"]??"",
    status: json["status"]??"",
    parentId: json["parent_id"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    subCategory: json["sub_category"] == null ? null : List<Datum>.from(json["sub_category"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "status": status,
    "parent_id": parentId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "sub_category": subCategory == null ? null : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
  };
}
