// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatModel {
  String? toID;
  String? fromID;
  String? message;
  String? media;
  String? timeStamp;
  ChatModel({
    this.toID,
    this.fromID,
    this.message,
    this.media,
    this.timeStamp,
  });

  ChatModel copyWith({
    String? toID,
    String? fromID,
    String? message,
    String? media,
    String? timeStamp,
  }) {
    return ChatModel(
      toID: toID ?? this.toID,
      fromID: fromID ?? this.fromID,
      message: message ?? this.message,
      media: media ?? this.media,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'toID': toID,
      'fromID': fromID,
      'message': message,
      'media': media,
      'timeStamp': timeStamp,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      toID: map['toID'] != null ? map['toID'] as String : null,
      fromID: map['fromID'] != null ? map['fromID'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      media: map['media'] != null ? map['media'] as String : null,
      timeStamp: map['timeStamp'] != null ? map['timeStamp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(toID: $toID, fromID: $fromID, message: $message, media: $media, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.toID == toID &&
        other.fromID == fromID &&
        other.message == message &&
        other.media == media &&
        other.timeStamp == timeStamp;
  }

  @override
  int get hashCode {
    return toID.hashCode ^
        fromID.hashCode ^
        message.hashCode ^
        media.hashCode ^
        timeStamp.hashCode;
  }
}
