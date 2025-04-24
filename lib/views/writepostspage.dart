import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/widgets/actionbutton.dart';
import 'package:grad_app/widgets/actionbuttonfeedback.dart';
import 'package:grad_app/widgets/custompostappbar.dart';
import 'package:grad_app/widgets/themewriteeditpost.dart';

class WritePostPage extends StatefulWidget {
  const WritePostPage({super.key});

  @override
  State<WritePostPage> createState() => WritePostPageState();
}

class WritePostPageState extends State<WritePostPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomtoAppBar(title: 'New Post'),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ThemeWriteEditPost(
                        controller: controller,
                        authorName: 'Dr.Nada Abu Al - Halaweh',
                        authorImage:
                            'assets/WhatsApp Image 2025-02-03 at 17.52.32_ee5e3371.jpg',
                      ),
                      const Spacer(),
                      ActionButton(
                        value: 'Publish',
                        controller: controller,
                        onPressed: () {
                          ActionButtonFeedback.validatePost(
                            context,
                            currentText: controller.text,
                            isEdit: false,
                            onSuccess: () {
                              context
                                  .read<PostCubit>()
                                  .addPost(controller.text.trim());
                              Navigator.pop(context);
                            },
                          );
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
