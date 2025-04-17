import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/models/postsmodel.dart';
import 'package:grad_app/widgets/actionbutton.dart';
import 'package:grad_app/widgets/appbaar.dart';
import 'package:grad_app/widgets/themewriteeditpost.dart';

class EditPostPage extends StatefulWidget {
  final PostModel post;

  const EditPostPage({super.key, required this.post});

  @override
  State<EditPostPage> createState() => EditPostPageState();
}

class EditPostPageState extends State<EditPostPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.post.content);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Edit Post'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      ThemeWriteEditPost(controller: controller, isEdit: true),
                      const Spacer(),
                      const SizedBox(height: 20),
                      ActionButton(
                        value: 'Save Changes',
                        controller: controller,
                        onPressed: () {
                          final newContent = controller.text.trim();
                          final oldContent = widget.post.content.trim();
                          if (newContent.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Post cannot be empty")),
                            );
                            return;
                          }
                          if (newContent == oldContent) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("No changes were made")),
                            );
                            return;
                          }
                          context
                              .read<PostCubit>()
                              .editPost(widget.post.id, newContent);
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
