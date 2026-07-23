import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/home/data/models/chat_user_model.dart';

abstract class HomeRepo {
  // Future<UserModel> getCurrentUser();
  Future<List<UserModel>> getAllUsers();
  Future<ChatUserModel> getChatUserInfo(UserModel user);
}
