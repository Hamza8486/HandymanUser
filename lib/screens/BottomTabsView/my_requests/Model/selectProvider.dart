// To parse this JSON data, do
//
//     final selectProviderResponse = selectProviderResponseFromJson(jsonString);

import 'dart:convert';

SelectProviderResponse selectProviderResponseFromJson(String str) => SelectProviderResponse.fromJson(json.decode(str));

String selectProviderResponseToJson(SelectProviderResponse data) => json.encode(data.toJson());

class SelectProviderResponse {
  SelectProviderResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  SelectProviderModel data;

  factory SelectProviderResponse.fromJson(Map<String, dynamic> json) => SelectProviderResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: SelectProviderModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class SelectProviderModel {
  SelectProviderModel({
    required this.id,
    this.subId,
    required  this.providerId,
    required  this.postId,
    required  this.cusId,
    required  this.description,
    required  this.budget,
    this.address,
    required  this.image,
    required  this.date,
    required this.status,
    this.phoneNo,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  dynamic subId;
  String providerId;
  int postId;
  String cusId;
  String description;
  String budget;
  dynamic address;
  String image;
  DateTime date;
  int status;
  dynamic phoneNo;
  DateTime createdAt;
  DateTime updatedAt;

  factory SelectProviderModel.fromJson(Map<String, dynamic> json) => SelectProviderModel(
    id: json["id"],
    subId: json["sub_id"],
    providerId: json["provider_id"]??"",
    postId: json["post_id"]??0,
    cusId: json["cus_id"]??"",
    description: json["description"]??"",
    budget: json["budget"]??"",
    address: json["address"],
    image: json["image"]??"",
    date: DateTime.parse(json["date"]),
    status: json["status"]??0,
    phoneNo: json["phone_no"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_id": subId,
    "provider_id": providerId,
    "post_id": postId,
    "cus_id": cusId,
    "description": description,
    "budget": budget,
    "address": address,
    "image": image,
    "date": date.toIso8601String(),
    "status": status,
    "phone_no": phoneNo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
