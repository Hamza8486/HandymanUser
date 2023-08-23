// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    required this.statusCode,
    required this.message,
    required  this.data,
  });

  int statusCode;
  String message;
  ProfileModel data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: ProfileModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class ProfileModel {
  ProfileModel({
    required this.id,
    required  this.firstName,
    required  this.lastName,
    required  this.phoneNo,
    required  this.address,
    required  this.userAddress,
    required  this.userLat,
    required  this.userLong,
    this.email,
    this.image,
    required  this.userId,
    required  this.createdAt,
    required  this.updatedAt,
    this.city,
  });

  int id;
  String firstName;
  String lastName;
  String phoneNo;
  String address;
  String userAddress;
  String userLat;
  String userLong;
  dynamic email;
  dynamic image;
  var userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic city;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    phoneNo: json["phone_no"]??"",
    address: json["address"]??"",
    userAddress: json["user_address"]??"",
    userLat: json["user_lat"]??"",
    userLong: json["user_long"]??"",
    email: json["email"],
    image: json["image"],
    userId: json["user_id"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    city: json["city"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_no": phoneNo,
    "address": address,
    "user_address": userAddress,
    "user_lat": userLat,
    "user_long": userLong,
    "email": email,
    "image": image,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "city": city,
  };
}
