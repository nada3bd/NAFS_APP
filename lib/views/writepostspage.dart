import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/widgets/actionbutton.dart';
import 'package:grad_app/widgets/appbaar.dart';
import 'package:grad_app/widgets/themeforwritepost.dart';

class WritePostPage extends StatefulWidget {
  const WritePostPage({super.key});

  @override
  State<WritePostPage> createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "New Post"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ThemeForWritePost(controller: _controller),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  context.read<PostCubit>().addPost(_controller.text.trim());
                  Navigator.pop(context);
                }
              },
              child:  ActionButton( value: 'Publish'),
            ),
          ],
        ),
      ),
    );
  }
}

