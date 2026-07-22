import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageInput extends StatefulWidget {
  final String receiverId;
  MessageInput({super.key, required this.receiverId});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    print('Before send');

    await context.read<ChatCubit>().sendMessage(
      receiverId: widget.receiverId,
      message: text,
    );

    print('After send');

    controller.clear();
  }

  // Future<void> _sendMessage() async {
  //   final text = controller.text.trim();

  //   if (text.isEmpty) return;

  //   await context.read<ChatCubit>().sendMessage(
  //     receiverId: widget.receiverId,
  //     message: text,
  //   );

  //   controller.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 1,
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter your message',
                  prefixIcon: Icon(Icons.message),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
