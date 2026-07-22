import 'package:chat_app/features/chat/data/models/message_model.dart';

abstract class ChatRepo {
  Future<void> sendMessage({
    required String receiverId,
    required String message,
  });
  Stream<List<MessageModel>> getMessages({required String receiverId});
}
