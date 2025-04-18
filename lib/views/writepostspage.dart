import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/widgets/actionbutton.dart';
import 'package:grad_app/widgets/appbaar.dart';
import 'package:grad_app/widgets/actionbuttonfeedback.dart';
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
      appBar: const CustomAppBar(title: "New Post"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ThemeWriteEditPost(controller: controller),
                        const Spacer(),
                        ActionButton(
                          value: 'Publish',
                          controller: controller,
                          onPressed: () {
                            ActionButtonFeedback.show(
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
                      ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
