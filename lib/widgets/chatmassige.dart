import 'package:flutter/material.dart';
import 'package:grad_app/models/chatpage.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final String? doctorImage;

  const ChatMessageWidget({
    super.key,
    required this.message,
    this.doctorImage,
  });

  @override
  Widget build(BuildContext context) {
    final messageBubble = Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
      decoration: BoxDecoration(
        color: message.isDoctor ? Colors.grey[300] : const Color(0xFF009688),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(message.isDoctor ? 0 : 12),
          bottomRight: Radius.circular(message.isDoctor ? 12 : 0),
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
        ),
      ),
      child: Text(
        message.text,
        style: TextStyle(color: message.isDoctor ? Colors.black : Colors.white),
      ),
    );

    return Align(
      alignment:
          message.isDoctor ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisAlignment:
            message.isDoctor ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (message.isDoctor)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: doctorImage != null
                    ? (doctorImage!.startsWith('http')
                        ? NetworkImage(doctorImage!)
                        : AssetImage(doctorImage!) as ImageProvider)
                    : const AssetImage(''),
              ),
            ),
          messageBubble,
        ],
      ),
    );
  }
}
