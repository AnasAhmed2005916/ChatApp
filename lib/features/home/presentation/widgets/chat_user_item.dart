import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatUserItem extends StatelessWidget {
  const ChatUserItem({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(AppRoutes.chat, extra: user);
      },
      leading: CircleAvatar(
        backgroundImage: user.imageUrl.isNotEmpty
            ? NetworkImage(user.imageUrl)
            : null,
        child: user.imageUrl.isEmpty ? Text(user.name[0].toUpperCase()) : null,
      ),
      title: Text(user.name),
      subtitle: Text(user.about, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Icon(
        Icons.circle,
        color: user.isOnline ? Colors.green : Colors.grey,
        size: 12,
      ),
    );
  }
}
