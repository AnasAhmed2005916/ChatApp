import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/features/home/data/models/chat_user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_app/core/utils/date_formatter.dart';

class ChatUserItem extends StatelessWidget {
  const ChatUserItem({super.key, required this.chatUser});

  final ChatUserModel chatUser;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(AppRoutes.chat, extra: chatUser.user);
      },
      leading: CircleAvatar(
        backgroundImage: chatUser.user.imageUrl.isNotEmpty
            ? NetworkImage(chatUser.user.imageUrl)
            : null,
        child: chatUser.user.imageUrl.isEmpty
            ? Text(chatUser.user.name[0].toUpperCase())
            : null,
      ),
      title: Text(chatUser.user.name),
      subtitle: Text(
        chatUser.lastMessage.isEmpty
            ? chatUser.user.about
            : chatUser.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: chatUser.lastMessageTime == null
          ? null
          : Text(
              DateFormatter.formatTime(chatUser.lastMessageTime!),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
    );
  }
}
