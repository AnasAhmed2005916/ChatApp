import 'package:chat_app/features/auth/data/models/user_model.dart';

class ChatUserModel {
  final UserModel user;
  final String lastMessage;
  final DateTime? lastMessageTime;
  ChatUserModel({
    required this.user,
    required this.lastMessage,
    this.lastMessageTime,
  });
}
