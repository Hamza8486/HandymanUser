// To parse this JSON data, do
//
//     final getProviderChatModel = getProviderChatModelFromJson(jsonString);

import 'dart:convert';

GetProviderChatModel getProviderChatModelFromJson(String str) => GetProviderChatModel.fromJson(json.decode(str));

String getProviderChatModelToJson(GetProviderChatModel data) => json.encode(data.toJson());



class GetProviderChatModel {
  int? statusCode;
  String? message;
  Data? data;

  GetProviderChatModel({this.statusCode, this.message, this.data});

  GetProviderChatModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ChatsAllModels>? chats;


  Data({this.chats, });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = <ChatsAllModels>[];
      json['chats'].forEach((v) {
        chats!.add(new ChatsAllModels.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ChatsAllModels {
  int? id;
  String? messageFromModal;
  String? messageToModal;
  String? message;
  var isRead;
  String? img;
  String? createdAt;

  ChatsAllModels(
      {this.id,
        this.messageFromModal,
        this.messageToModal,
        this.img,
        this.message,
        this.isRead,
        this.createdAt});

  ChatsAllModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageFromModal = json['message_from_modal'];
    messageToModal = json['message_to_modal'];
    message = json['message'];
    img = json['img'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message_from_modal'] = this.messageFromModal;
    data['message_to_modal'] = this.messageToModal;
    data['message'] = this.message;
    data['is_read'] = this.isRead;
    data['img'] = this.img;
    data['created_at'] = this.createdAt;
    return data;
  }
}


