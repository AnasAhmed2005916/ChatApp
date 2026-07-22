import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_state.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:chat_app/features/chat/presentation/widgets/message_bubble.dart';
import 'package:chat_app/features/chat/presentation/widgets/message_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatefulWidget {
  ChatView({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  void initState() {
    super.initState();

    context.read<ChatCubit>().listenToMessages(receiverId: widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(user: widget.user),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatError) {
            return Center(child: Text(state.message));
          }
          if (state is ChatLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,

                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message =
                          state.messages[state.messages.length - 1 - index];
                      return MessageBubble(message: message);
                    },
                  ),
                ),
                MessageInput(receiverId: widget.user.uid),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
