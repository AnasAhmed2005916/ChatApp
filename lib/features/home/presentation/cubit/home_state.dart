import 'package:chat_app/features/home/data/models/chat_user_model.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

final class HomeUsersLoaded extends HomeState {
  final List<ChatUserModel> chatUsers;
  HomeUsersLoaded(this.chatUsers);
}
