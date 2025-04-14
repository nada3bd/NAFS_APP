import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/chatcubit.dart';

class ChatMessageInput extends StatelessWidget {
  final TextEditingController controller;
  final ScrollController scrollController;

  const ChatMessageInput({
    super.key,
    required this.controller,
    required this.scrollController,
  });

  void _sendMessage(BuildContext context) {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      context.read<ChatCubit>().addMessage(text, false);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                hintText: 'Type a message',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  context.read<ChatCubit>().addMessage(value.trim(), false);
                  controller.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 3),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.teal),
            onPressed: () {
            },
          ),
          const SizedBox(width: 3),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF009688)),
            onPressed: () => _sendMessage(context),
          ),
        ],
      ),
    );
  }
}