import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/date_formatter.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  bool get isMe => message.senderId == FirebaseAuth.instance.currentUser!.uid;
  MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color:
              isMe
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isMe ? 18 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 18),
          ),
        ),
        constraints: const BoxConstraints(maxWidth: 280),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.message,
              softWrap: true,
              textAlign: TextAlign.start,

              style: TextStyle(color: isMe ? Colors.white : Colors.black87),
            ),
            Align(
              alignment: Alignment.bottomRight,

              child: Text(
                DateFormatter.formatTime(message.sentAt),

                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isMe ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
