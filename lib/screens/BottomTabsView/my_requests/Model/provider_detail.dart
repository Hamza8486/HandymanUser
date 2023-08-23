// To parse this JSON data, do
//
//     final providerDetailModel = providerDetailModelFromJson(jsonString);

import 'dart:convert';

ProviderDetailModel? providerDetailModelFromJson(String str) => ProviderDetailModel.fromJson(json.decode(str));

String providerDetailModelToJson(ProviderDetailModel? data) => json.encode(data!.toJson());





class ProviderDetailModel {
  int? statusCode;
  String? message;
  ProviderModelData? data;

  ProviderDetailModel({this.statusCode, this.message, this.data});

  ProviderDetailModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new ProviderModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProviderModelData {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? address;
  var userId;
  String? image;
  String? aboutMe;
  var age;
  var verify;
  var favorite;
  var status;
  String? createdAt;
  String? updatedAt;
  var avgRating;
  var ratingCount;
  List<Portfolio>? portfolio;
  List<Rating>? ratings;

  List<SubCategory>? subCategory;

  ProviderModelData(
      {this.id,
        this.firstName,
        this.lastName,
        this.ratings,
        this.phoneNo,
        this.address,
        this.userId,
        this.image,
        this.aboutMe,
        this.portfolio,

        this.age,
        this.verify,
        this.favorite,
        this.status,
        this.createdAt,
        this.updatedAt,


        this.avgRating,
        this.ratingCount,
        this.subCategory,
        });

  ProviderModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNo = json['phone_no'];
    address = json['address'];

    if (json['portfolio'] != null) {
      portfolio = <Portfolio>[];
      json['portfolio'].forEach((v) {
        portfolio!.add(new Portfolio.fromJson(v));
      });
    }
    userId = json['user_id'];
    image = json['image'];
    aboutMe = json['about_me'];
    age = json['age'];
    verify = json['verify'];
    favorite = json['favorite'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    avgRating = json['avgRating'];
    ratingCount = json['ratingCount'];
    if (json['sub_category'] != null) {
      subCategory = <SubCategory>[];
      json['sub_category'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = <Rating>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Rating.fromJson(v));
      });
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_no'] = this.phoneNo;
    data['address'] = this.address;
    data['user_id'] = this.userId;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['about_me'] = this.aboutMe;
    data['age'] = this.age;
    data['verify'] = this.verify;
    data['favorite'] = this.favorite;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    data['avgRating'] = this.avgRating;
    data['ratingCount'] = this.ratingCount;
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Portfolio {
  int? id;
  String? image;
  String? createdAt;
  String? updatedAt;
  var proId;

  Portfolio({this.id, this.image, this.createdAt, this.updatedAt, this.proId});

  Portfolio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    proId = json['pro_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pro_id'] = this.proId;
    return data;
  }
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

  var id;
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

class SubCategory {
  int? id;
  String? name;
  String? description;
  String? image;
  var status;
  var feature;
  var parentId;
  String? createdAt;
  String? updatedAt;
  var price;
  var objectId;

  SubCategory(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.status,
        this.feature,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.price,
        this.objectId});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    feature = json['feature'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    objectId = json['object_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['feature'] = this.feature;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['price'] = this.price;
    data['object_id'] = this.objectId;
    return data;
  }
}


class Pivot {
  var providerId;
  var serviceId;

  Pivot({this.providerId, this.serviceId});

  Pivot.fromJson(Map<String, dynamic> json) {
    providerId = json['provider_id'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider_id'] = this.providerId;
    data['service_id'] = this.serviceId;
    return data;
  }
}
