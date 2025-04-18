import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/feedbackcubit.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/views/postslistpage.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FeedBackCubit>(
          create: (context) => FeedBackCubit(),
        ),
        BlocProvider<PostCubit>(
          create: (context) => PostCubit()..loadPosts(),
        ),
      ],
      child: const NafsApp(),
    ),
  );
}

class NafsApp extends StatelessWidget {
  const NafsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Color(0xFF009688),
    //   statusBarIconBrightness: Brightness.light,
    // ));

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostListPage(isDoctor: true),
    );
  }
}
