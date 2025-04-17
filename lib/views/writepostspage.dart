import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/widgets/actionbutton.dart';
import 'package:grad_app/widgets/appbaar.dart';
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
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:[
                    ThemeWriteEditPost(controller: controller),
                    const Spacer(),
                    ActionButton(
                      value: 'Publish',
                      controller: controller,
                      onPressed: () {
                        final text = controller.text.trim();

                        if (text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Post cannot be empty")),
                          );
                          return;
                        }

                        context.read<PostCubit>().addPost(text);

                        Navigator.pop(context);
                      },
                    ),
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
