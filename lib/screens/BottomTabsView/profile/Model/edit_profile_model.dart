// To parse this JSON data, do
//
//     final editProfileResponse = editProfileResponseFromJson(jsonString);

import 'dart:convert';

EditProfileResponse editProfileResponseFromJson(String str) => EditProfileResponse.fromJson(json.decode(str));

String editProfileResponseToJson(EditProfileResponse data) => json.encode(data.toJson());

class EditProfileResponse {
  EditProfileResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) => EditProfileResponse(
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
    required this.id,
    required this.phoneNo,
    required this.email,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.address,
    required  this.userId,
    required  this.createdAt,
    required  this.updatedAt,
  });

  int id;
  String phoneNo;
  String email;
  String image;
  String firstName;
  String lastName;
  String address;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    phoneNo: json["phone_no"],
    email: json["email"],
    image: json["image"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    address: json["address"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone_no": phoneNo,
    "email": email,
    "image": image,
    "first_name": firstName,
    "last_name": lastName,
    "address": address,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
