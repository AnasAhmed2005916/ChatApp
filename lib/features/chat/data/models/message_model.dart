import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime sentAt;
  final String type;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sentAt,
    required this.type,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      sentAt: (json['sentAt'] as Timestamp).toDate(),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'sentAt': sentAt,
      'type': type,
    };
  }
}
