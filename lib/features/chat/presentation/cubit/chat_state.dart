import 'package:chat_app/features/chat/data/models/message_model.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<MessageModel> messages;

  ChatLoaded(this.messages);
}

final class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
