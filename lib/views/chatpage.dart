import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/chatcubit.dart';
import 'package:grad_app/models/chatpage.dart';
import 'package:grad_app/models/doctorprofile.dart';
import 'package:grad_app/widgets/appbaar.dart';
import 'package:grad_app/widgets/chatmassige.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.doctorProfile});

  final DoctorProfile doctorProfile;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showNewMessageIndicator = false;
  int _previousMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent - 20) {
        if (_showNewMessageIndicator) {
          setState(() {
            _showNewMessageIndicator = false;
          });
        }
      }
    });
    SchedulerBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        title: widget.doctorProfile.name,
        actions: const [
          Icon(Icons.videocam_off, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: BlocListener<ChatCubit, List<ChatMessage>>(
        listener: (context, messages) {
          if (_previousMessageCount == 0) {
            SchedulerBinding.instance
                .addPostFrameCallback((_) => _scrollToBottom());
          }
          if (messages.length > _previousMessageCount) {
            if (_scrollController.offset <
                _scrollController.position.maxScrollExtent - 20) {
              setState(() {
                _showNewMessageIndicator = true;
              });
            } else {
              SchedulerBinding.instance
                  .addPostFrameCallback((_) => _scrollToBottom());
            }
          }
          _previousMessageCount = messages.length;
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit, List<ChatMessage>>(
                    builder: (context, messages) {
                      return ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return ChatMessageWidget(message: messages[index]  ,doctorImage:widget.doctorProfile.image ,);
                        },
                      );
                    },
                  ),
                ),
                const Divider(height: 1, color: Colors.transparent),
                Container(
                  width: double.infinity,
                  height: 70,
                  color: Colors.grey[200],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
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
                              context
                                  .read<ChatCubit>()
                                  .addMessage(value.trim(), false);
                              controller.clear();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width:3),
                      IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.teal),
                        onPressed: () {
                          
                        },
                      ),
                      const SizedBox(width: 3),
                      IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFF009688)),
                        onPressed: () {
                          final text = controller.text.trim();
                          if (text.isNotEmpty) {
                            context.read<ChatCubit>().addMessage(text, false);
                            controller.clear();
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (_showNewMessageIndicator)
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _scrollToBottom();
                    setState(() => _showNewMessageIndicator = false);
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 12, 12, 12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'New Message',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
