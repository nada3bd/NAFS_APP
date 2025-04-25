import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/chatcubit.dart';
import 'package:grad_app/models/chatpage.dart';
import 'package:grad_app/views/chatpage.dart';
import 'package:grad_app/views/doctorinformationspage.dart';
import 'package:grad_app/widgets/theme_button.dart';

class OpenChatButton extends StatelessWidget {
  const OpenChatButton({
    super.key,
    required this.widget,
  });

  final DoctorInformationsPage widget;

  @override
  Widget build(BuildContext context) {
    return ThemedButton(
      buttonText: 'Go to Chat',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => ChatCubit(initialMessages: [
                ChatMessage(isDoctor: false, text: 'hi, can i book a session'),
                ChatMessage(
                    isDoctor: true, text: 'hi, yes but first we need to'),
              ]),
              child: ChatPage(doctorProfile: widget.doctorProfile),
            ),
          ),
        );
      },
    );
  }
}
