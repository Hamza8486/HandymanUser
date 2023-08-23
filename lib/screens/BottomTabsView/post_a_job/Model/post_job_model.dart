// To parse this JSON data, do
//
//     final postJobResponse = postJobResponseFromJson(jsonString);

import 'dart:convert';

PostJobResponse postJobResponseFromJson(String str) => PostJobResponse.fromJson(json.decode(str));

String postJobResponseToJson(PostJobResponse data) => json.encode(data.toJson());

class PostJobResponse {
  PostJobResponse({
    required this.statusCode,
    required this.message,
  });

  int statusCode;
  String message;

  factory PostJobResponse.fromJson(Map<String, dynamic> json) => PostJobResponse(
    statusCode: json["statusCode"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
  };
}
