// To parse this JSON data, do
//
//     final favouriteResponse = favouriteResponseFromJson(jsonString);

import 'dart:convert';

FavouriteResponse favouriteResponseFromJson(String str) => FavouriteResponse.fromJson(json.decode(str));

String favouriteResponseToJson(FavouriteResponse data) => json.encode(data.toJson());

class FavouriteResponse {
  FavouriteResponse({
    required this.statusCode,
    required this.message,
    required  this.data,
  });

  int statusCode;
  String message;
  List<String> data;

  factory FavouriteResponse.fromJson(Map<String, dynamic> json) => FavouriteResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
