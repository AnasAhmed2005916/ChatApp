import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:chat_app/features/home/data/models/chat_user_model.dart';
import 'package:chat_app/features/home/data/repos/home_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepoImpl implements HomeRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<UserModel> getCurrentUser() async {
  //   final currentUser = auth.currentUser;
  //   if (currentUser == null) {
  //     throw Exception('No user is logged in.');
  //   }
  //   final doc = await firestore.collection('users').doc(currentUser.uid).get();
  //   if (!doc.exists) {
  //     throw Exception('User data no found');
  //   }
  //   return UserModel.fromJson(doc.data()!);
  // }
  @override
  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await firestore.collection('users').get();
    final users = snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      throw Exception('No authenticated user.');
    }
    users.removeWhere((user) => user.uid == currentUser.uid);
    return users;
  }

  Future<ChatUserModel> getChatUserInfo(UserModel user) async {
    final currentUser = auth.currentUser!;
    final senderId = currentUser.uid;
    String chatId;
    if (senderId.compareTo(user.uid) < 0) {
      chatId = '${senderId}_${user.uid}';
    } else {
      chatId = '${user.uid}_$senderId';
    }
    final snapshot = await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('sentAt', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      return ChatUserModel(user: user, lastMessage: '', lastMessageTime: null);
    }
    final message = MessageModel.fromJson(snapshot.docs.first.data());
    return ChatUserModel(
      user: user,
      lastMessage: message.message,
      lastMessageTime: message.sentAt,
    );
  }
}
