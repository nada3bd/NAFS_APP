import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/chatcubit.dart';
import 'package:grad_app/models/chatpage.dart';
import 'package:grad_app/models/doctorprofile.dart';
import 'package:grad_app/widgets/appbaar.dart';
import 'package:grad_app/widgets/chatmassige.dart';
import 'package:grad_app/widgets/chatmassigeinput.dart';
import 'package:grad_app/widgets/newchat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.doctorProfile});
  final DoctorProfile doctorProfile;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showNewMsgIndicator = false;
  int _prevMessageCount = 0;
  late final bool isDoctor;


  @override
  void initState() {
    super.initState();
    isDoctor = false;
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 20) {
        if (_showNewMsgIndicator) {
          setState(() => _showNewMsgIndicator = false);
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
    _messageController.dispose();
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
          if (_prevMessageCount == 0) {
            SchedulerBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
          }
          if (messages.length > _prevMessageCount) {
            if (_scrollController.offset < _scrollController.position.maxScrollExtent - 20) {
              setState(() => _showNewMsgIndicator = true);
            } else {
              SchedulerBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
            }
          }
          _prevMessageCount = messages.length;
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
                        itemBuilder: (context, index) => ChatMessageWidget(
                          message: messages[index],
                          doctorImage: widget.doctorProfile.image,
                        ),
                      );
                    },
                  ),
                ),
                ChatMessageInput(
                  controller: _messageController,
                  scrollController: _scrollController,
                  isDoctor : isDoctor ,
                ),
              ],
            ),
            if (_showNewMsgIndicator)
              NewMessageIndicator(
                onTap: () {
                  _scrollToBottom();
                  setState(() => _showNewMsgIndicator = false);
                },
              ),
          ],
        ),
      ),
    );
  }
}