// To parse this JSON data, do
//
//     final providerListResponse = providerListResponseFromJson(jsonString);

import 'dart:convert';

ProviderListResponse providerListResponseFromJson(String str) => ProviderListResponse.fromJson(json.decode(str));

String providerListResponseToJson(ProviderListResponse data) => json.encode(data.toJson());

class ProviderListResponse {
  ProviderListResponse({
    required this.statusCode,
    required  this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<Datum> data;

  factory ProviderListResponse.fromJson(Map<String, dynamic> json) => ProviderListResponse(
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
    required  this.firstName,
    required  this.lastName,
    required this.phoneNo,
    required  this.address,
    required  this.userId,
    required this.subCatId,
    required  this.image,
    required  this.aboutMe,
    required  this.age,
    required this.verify,
    required this.favorite,
    this.createdAt,
    required this.portfolio,
    this.updatedAt,
    required this.avgRating,
    required this.ratingCount,
    required this.ratings,
    required this.service,
  });

  var id;
  String firstName;
  String lastName;
  String phoneNo;
  String address;
  var userId;
  var subCatId;
  var image;
  String aboutMe;
  String ? age;
  var verify;
  var favorite;
  dynamic createdAt;
  dynamic updatedAt;
  List<Portfolio> portfolio;
  var avgRating;
  var ratingCount;
  List<Rating> ratings;
  List<Service> service;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    phoneNo: json["phone_no"]??"",
    address: json["address"]??"",
    userId: json["user_id"]??"",
    subCatId: json["sub_cat_id"]??"",
    image: json["image"]??"",
    aboutMe: json["about_me"]??"",
    age: json["age"]??"",
    verify: json["verify"]??"",
    favorite: json["favorite"]??"",
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    avgRating: json["avgRating"]??0,
    portfolio: List<Portfolio>.from(json["portfolio"].map((x) => Portfolio.fromJson(x))),

    ratingCount: json["ratingCount"]??0,
    ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    service: List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_no": phoneNo,
    "address": address,
    "user_id": userId,
    "sub_cat_id": subCatId,
    "image": image,
    "about_me": aboutMe,
    "age": age,
    "verify": verify,
    "favorite": favorite,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "avgRating": avgRating,
    "portfolio": List<dynamic>.from(portfolio.map((x) => x.toJson())),

    "ratingCount": ratingCount,
    "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
    "service": List<dynamic>.from(service.map((x) => x.toJson())),
  };
}

class Portfolio {
  Portfolio({
    required this.id,
    required this.image,
    required  this.createdAt,
    required this.updatedAt,
    required  this.proId,
  });

  int id;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  var proId;

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
    id: json["id"],
    image: json["image"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    proId: json["pro_id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pro_id": proId,
  };
}


class Rating {
  Rating({
    required this.id,
    required  this.name,
    required this.description,
    required this.rating,
    required  this.image,
    required  this.customerId,
    required  this.providerId,
    this.parentId,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  var rating;
  String image;
  var customerId;
  var providerId;
  dynamic parentId;
  var status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    name: json["name"]??"",
    description: json["description"]??"",
    rating: json["rating"]??"",
    image: json["image"]??"",
    customerId: json["customer_id"]??"",
    providerId: json["provider_id"]??"",
    parentId: json["parent_id"],
    status: json["status"]??"",
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "rating": rating,
    "image": image,
    "customer_id": customerId,
    "provider_id": providerId,
    "parent_id": parentId,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Service {
  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.status,
    this.feature,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
    required this.price,

  });

  int id;
  String name;
  String description;
  String image;
  var status;
  dynamic feature;
  var parentId;
  DateTime createdAt;
  DateTime updatedAt;
  var price;


  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    feature: json["feature"],
    parentId: json["parent_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "status": status,
    "feature": feature,
    "parent_id": parentId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "price": price,

  };
}


