// To parse this JSON data, do
//
//     final changeAddressResponse = changeAddressResponseFromJson(jsonString);

import 'dart:convert';

ChangeAddressResponse changeAddressResponseFromJson(String str) => ChangeAddressResponse.fromJson(json.decode(str));

String changeAddressResponseToJson(ChangeAddressResponse data) => json.encode(data.toJson());

class ChangeAddressResponse {
  ChangeAddressResponse({
    required this.statusCode,
    required this.message,
  });

  int statusCode;
  String message;

  factory ChangeAddressResponse.fromJson(Map<String, dynamic> json) => ChangeAddressResponse(
    statusCode: json["statusCode"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
  };
}
