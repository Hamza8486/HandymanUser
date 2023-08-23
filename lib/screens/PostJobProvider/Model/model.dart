// To parse this JSON data, do
//
//     final postJobProviderResponse = postJobProviderResponseFromJson(jsonString);

import 'dart:convert';

PostJobProviderResponse postJobProviderResponseFromJson(String str) => PostJobProviderResponse.fromJson(json.decode(str));

String postJobProviderResponseToJson(PostJobProviderResponse data) => json.encode(data.toJson());

class PostJobProviderResponse {
  PostJobProviderResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory PostJobProviderResponse.fromJson(Map<String, dynamic> json) => PostJobProviderResponse(
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
    required this.cusId,
    required this.providerId,
    required this.description,
    required this.address,
    required this.budget,
    required this.date,
    required this.image,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String cusId;
  String providerId;
  String description;
  String address;
  String budget;
  DateTime date;
  String image;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cusId: json["cus_id"],
    providerId: json["provider_id"],
    description: json["description"],
    address: json["address"],
    budget: json["budget"],
    date: DateTime.parse(json["date"]),
    image: json["image"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "cus_id": cusId,
    "provider_id": providerId,
    "description": description,
    "address": address,
    "budget": budget,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "image": image,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
