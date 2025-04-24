import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/chatlistcubit.dart';
import 'package:grad_app/cubit/feedbackcubit.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/cubit/themecubit.dart';
import 'package:grad_app/models/doctorprofile.dart';
import 'package:grad_app/views/doctorinformationspage.dart';


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
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
         BlocProvider(create: (_) => ChatListCubit()),
      ],
      child: const NafsApp(),
    ),
  );
}

class NafsApp extends StatelessWidget {
  const NafsApp({super.key});

  @override
    Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, currentTheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: currentTheme,
          home:   DoctorInformationsPage(doctorProfile: DoctorProfile(
            image: 'assets/images/doctor1.jpg',
            name: 'Dr.Nada Abu Al - Halaweh',
            specialization: 'Cardiologist',
            rating: 4, location: 'Cairo, Egypt', feedback: [], avatarIcon: '', aboutMe: '', sessionDuration: '', sessionPrice: '',

            
          )
          
            ,),
           
        );
      },
    );
  }

}
