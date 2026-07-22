import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:chat_app/features/chat/data/repos/chat_repo.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  ChatCubit(this.chatRepo) : super(ChatInitial());
  Future<void> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    try {
      if (message.trim().isEmpty) return;
      await chatRepo.sendMessage(receiverId: receiverId, message: message);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void listenToMessages({required String receiverId}) {
    emit(ChatLoading());
    _messagesSubscription?.cancel();

    _messagesSubscription = chatRepo
        .getMessages(receiverId: receiverId)
        .listen(
          (messages) {
            emit(ChatLoaded(messages));
          },
          onError: (e) {
            print(e);
            emit(ChatError(e.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
