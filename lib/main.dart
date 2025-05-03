import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:dio/dio.dart';
import 'package:grad_app/cubit/chatlistcubit.dart';
import 'package:grad_app/cubit/feedbackcubit.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/cubit/themecubit.dart';
//import 'package:grad_app/cubit/vedio_cubit.dart';
import 'package:grad_app/models/doctorprofile.dart';
import 'package:grad_app/views/doctorinformationspage.dart';
//import 'package:grad_app/views/vedio_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => FeedBackCubit()),
      BlocProvider(create: (_) => PostCubit()..loadPosts()),
      BlocProvider(create: (_) => ThemeCubit()),
      BlocProvider(create: (_) => ChatListCubit()),
      // BlocProvider(create: (_) => VideosCubit(Dio())),
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
        home: DoctorInformationsPage(
            doctorProfile: DoctorProfile(
          name: 'Dr. Ahmed',
          rating: 45,
          image:
              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
          location: 'mm',
          feedback: [],
          avatarIcon: '',
          sessionPrice: '',
          aboutMe: '',
           sessionDuration: '', 
          specialization: '',
        )),
        // const VideoListPage(),
      ),
    );
  }
}
