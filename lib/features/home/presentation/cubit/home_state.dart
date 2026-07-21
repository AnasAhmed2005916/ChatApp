import 'package:chat_app/features/auth/data/models/user_model.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final UserModel user;

  HomeLoaded(this.user);
}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
