import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/cubit/postsstate.dart';
import 'package:grad_app/views/writepostspage.dart';
import 'package:grad_app/widgets/appbaar.dart';
import 'package:grad_app/widgets/postscard.dart';

class PostListPage extends StatelessWidget {
  final bool isDoctor;

  const PostListPage({super.key, required this.isDoctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Posts'),
      body: BlocProvider(
        create: (_) => PostCubit()..loadPosts(),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostLoaded) {
              return ListView(
                padding: const EdgeInsets.only(bottom: 80),
                children: state.posts
                    .map(
                      (post) => PostCard(
                        post: post,
                        isDoctor: isDoctor,
                        onDelete: () =>
                            context.read<PostCubit>().deletePost(post.id),
                      ),
                    )
                    .toList(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: isDoctor
          ? Padding(
              padding: const EdgeInsets.only(bottom: 22, right: 14),
              child: FloatingActionButton(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const WritePostPage()));
                },
                child: const Icon(Icons.edit),
              ),
            )
          : null,
    );
  }
}
