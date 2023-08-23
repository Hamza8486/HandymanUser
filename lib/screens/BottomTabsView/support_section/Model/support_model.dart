// To parse this JSON data, do
//
//     final supportListResponse = supportListResponseFromJson(jsonString);

import 'dart:convert';

SupportListResponse supportListResponseFromJson(String str) => SupportListResponse.fromJson(json.decode(str));

String supportListResponseToJson(SupportListResponse data) => json.encode(data.toJson());

class SupportListResponse {
  SupportListResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<SupportModel> data;

  factory SupportListResponse.fromJson(Map<String, dynamic> json) => SupportListResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<SupportModel>.from(json["data"].map((x) => SupportModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SupportModel {
  SupportModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.support,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String question;
  String answer;
  String support;
  DateTime createdAt;
  DateTime updatedAt;

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    support: json["support"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "support": support,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
