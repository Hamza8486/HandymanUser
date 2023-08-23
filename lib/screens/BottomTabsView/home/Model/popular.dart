// To parse this JSON data, do
//
//     final popularSubModel = popularSubModelFromJson(jsonString);

import 'dart:convert';

PopularSubModel popularSubModelFromJson(String str) => PopularSubModel.fromJson(json.decode(str));

String popularSubModelToJson(PopularSubModel data) => json.encode(data.toJson());



class PopularSubModel {
  int? statusCode;
  String? message;
  List<PopularData>? data;

  PopularSubModel({this.statusCode, this.message, this.data});

  PopularSubModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PopularData>[];
      json['data'].forEach((v) {
        data!.add(new PopularData.fromJson(v));
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

class PopularData {
  String? name;
  String? image;
  var id;

  PopularData({this.name, this.image, this.id});

  PopularData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['id'] = this.id;
    return data;
  }
}
