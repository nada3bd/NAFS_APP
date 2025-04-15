import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/cubit/postsstate.dart';
import 'package:grad_app/models/postsmodel.dart';

class EditPostPage extends StatefulWidget {
  final PostModel post;
  const EditPostPage({super.key, required this.post});

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.post.content);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: widget.post.image.isNotEmpty
    ? CircleAvatar(backgroundImage: AssetImage(widget.post.image))
    : const CircleAvatar(child: Icon(Icons.person)),

              title: const Text('Edit Your Post'),
            ),
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Edit your post here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    final newContent = _controller.text.trim();

                    if (newContent.isNotEmpty) {
                      context
                          .read<PostCubit>()
                          .editPost(widget.post.id, newContent);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Changes'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
