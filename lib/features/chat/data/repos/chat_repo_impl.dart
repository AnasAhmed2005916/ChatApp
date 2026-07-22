import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:chat_app/features/chat/data/repos/chat_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepoImpl implements ChatRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      throw Exception('No authenticated user.');
    }
    final senderId = currentUser.uid;
    String chatId;
    if (senderId.compareTo(receiverId) < 0) {
      chatId = '${senderId}_$receiverId';
    } else {
      chatId = '${receiverId}_$senderId';
    }
    final messageModel = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      sentAt: DateTime.now(),
      type: 'text',
    );
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(messageModel.toJson());
  }

  @override
  Stream<List<MessageModel>> getMessages({required String receiverId}) {
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      throw Exception('No authenticated user.');
    }
    final senderId = currentUser.uid;
    String chatId;
    if (senderId.compareTo(receiverId) < 0) {
      chatId = '${senderId}_$receiverId';
    } else {
      chatId = '${receiverId}_$senderId';
    }
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('sentAt')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList();
        });
  }
}
