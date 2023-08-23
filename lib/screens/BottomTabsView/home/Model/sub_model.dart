// To parse this JSON data, do
//
//     final serviceSubModel = serviceSubModelFromJson(jsonString);

import 'dart:convert';

ServiceSubModel serviceSubModelFromJson(String str) => ServiceSubModel.fromJson(json.decode(str));

String serviceSubModelToJson(ServiceSubModel data) => json.encode(data.toJson());



class ServiceSubModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  ServiceSubModel({this.statusCode, this.message, this.data});

  ServiceSubModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  var id;
  String? name;
  String? description;
  String? image;
  var status;
  var feature;
  var parentId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.status,
        this.feature,
        this.parentId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    feature = json['feature'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
