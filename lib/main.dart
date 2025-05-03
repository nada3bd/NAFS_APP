import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:grad_app/cubit/chatlistcubit.dart';
import 'package:grad_app/cubit/feedbackcubit.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/cubit/themecubit.dart';
import 'package:grad_app/cubit/vedio_cubit.dart';
import 'package:grad_app/views/vedio_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => FeedBackCubit()),
      BlocProvider(create: (_) => PostCubit()..loadPosts()),
      BlocProvider(create: (_) => ThemeCubit()),
      BlocProvider(create: (_) => ChatListCubit()),
      BlocProvider(create: (_) => VideosCubit(Dio())),
    ],
    child: const NafsApp(),
  ));
}

class NafsApp extends StatelessWidget {
  const NafsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const VideoListPage(),
      ),
    );
  }
}
