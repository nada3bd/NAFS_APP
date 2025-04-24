import 'package:flutter/material.dart';
import 'package:grad_app/models/chatlistcontact.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  final ChatContactModel chat;

  const ChatItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(chat.image),
        radius: 22,
      ),
      title: Text(
        chat.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(chat.message,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: theme.hintColor)),
          trailing: Text(DateFormat('hh:mm a').format(chat.time), style: TextStyle(color: theme.hintColor)),
      onTap: () {
      },
    );
  }
}
 