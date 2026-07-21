import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String uid;
  final String email;
  final String imageUrl;
  final String about;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime createdAt;

  const UserModel({
    required this.name,
    required this.uid,
    required this.email,
    required this.imageUrl,
    required this.about,
    required this.isOnline,
    required this.lastSeen,
    required this.createdAt,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      uid: json['uid'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      about: json['about'],
      isOnline: json['isOnline'],
      lastSeen: (json['lastSeen'] as Timestamp).toDate(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      'imageUrl': imageUrl,
      'about': about,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
      'createdAt': createdAt,
    };
  }
}
