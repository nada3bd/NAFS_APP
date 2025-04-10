import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:grad_app/cubit/Feedbackcubit.dart';
import 'package:grad_app/models/doctorprofile.dart';
import 'package:grad_app/views/doctorprofilepage.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FeedBackCubit>(
          create: (context) => FeedBackCubit(),
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF009688),
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      title: 'NafsApp',
      home: DoctorProfilePage(
        doctorProfile: DoctorProfile(
          image: 'assets/WhatsApp Image 2025-02-03 at 17.52.32_ee5e3371.jpg',
          name: 'Dr. Ruba Abed',
          rating: 4,
          avatarIcon:
              'assets/doctor_avatar.png', 
          aboutMe:
              'أخصائي نفسي يمتلك خبرة تزيد عن 10 سنوات في مجال العلاج النفسي، ويقدّم خدمات علاجية متخصصة في الاضطرابات النفسية المختلفة، ومشاكل العلاقات، والصدمات النفسية، بما في ذلك صدمات الطفولة. يهدف إلى مساعدة الأفراد على فهم أنفسهم بشكل أعمق، والتعامل مع تجاربهم المؤلمة، وتحقيق التوازن النفسي من خلال أساليب علاجية مبنية على أسس علمية ومهنية',
          sessionDuration: '00 : 45 m',
          sessionPrice: '15.00 JD',
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
