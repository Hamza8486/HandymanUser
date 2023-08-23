// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

ServicesModel servicesModelFromJson(String str) => ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());





class ServicesModel {
  int? statusCode;
  String? message;
  List<ServiceDataAll>? data;

  ServicesModel({this.statusCode, this.message, this.data});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServiceDataAll>[];
      json['data'].forEach((v) {
        data!.add(new ServiceDataAll.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceDataAll {
  int? id;
  String? name;
  String? description;
  String? image;
  var price;
  var parentId;
  var subId;
  var status;
  String? createdAt;
  String? updatedAt;
  int? categoryId;

  ServiceDataAll(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.categoryId,
        this.parentId,
        this.subId,
        this.status,
        this.createdAt,
        this.updatedAt});

  ServiceDataAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    parentId = json['parent_id'];
    subId = json['sub_id'];
    status = json['status'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['parent_id'] = this.parentId;
    data['sub_id'] = this.subId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
