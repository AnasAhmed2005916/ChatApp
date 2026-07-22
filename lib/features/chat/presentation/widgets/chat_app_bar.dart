import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final UserModel user;
  const ChatAppBar({super.key, required this.user});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            child: Text(
              user.name[0].toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 2),

                Text(
                  user.isOnline ? 'Online' : 'Offline',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: user.isOnline ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
