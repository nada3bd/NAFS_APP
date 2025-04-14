import 'package:grad_app/views/editprofilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/feedbackcubit.dart';
import 'package:grad_app/models/doctorprofile.dart';
import 'package:grad_app/widgets/customsafearea.dart';
import 'package:grad_app/widgets/doctorheader.dart';
import 'package:grad_app/widgets/expandableaboutme.dart';
import 'package:grad_app/widgets/feedbacksection.dart';
import 'package:grad_app/widgets/gotochat.dart';
import 'package:grad_app/widgets/infocard.dart';
import 'package:grad_app/widgets/sectiontitle.dart';
import 'package:grad_app/widgets/sessionprice.dart';

class DoctorInformationsPage extends StatefulWidget {
  final DoctorProfile doctorProfile;
  const DoctorInformationsPage({super.key, required this.doctorProfile});

  @override
  DoctorInformationsPageState createState() => DoctorInformationsPageState();
}

class DoctorInformationsPageState extends State<DoctorInformationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialFeedback =
        widget.doctorProfile.feedback.map((f) => {'message': f}).toList();

    return BlocProvider(
      create: (_) => FeedBackCubit(initialFeedback: initialFeedback),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomSafeArea(color: Colors.teal),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DoctorHeader(
                  name: widget.doctorProfile.name,
                  rating: widget.doctorProfile.rating,
                  image: widget.doctorProfile.image,
                ),
                const SizedBox(height: 20),
                const SectionTitle(title: 'About me'),
                const SizedBox(height: 5),
                SlideTransition(
                  position: _offsetAnimation,
                  child: InfoCard(
                    content: ExpandableAboutMe(
                      text: widget.doctorProfile.aboutMe,
                      maxLines: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SectionTitle(title: 'Feedback'),
                const SizedBox(height: 5),
                FeedbackSection(),
                const SizedBox(height: 20),
                SessionPriceInfo(
                  session: widget.doctorProfile.sessionDuration,
                  price: widget.doctorProfile.sessionPrice,
                  location: widget.doctorProfile.location,
                ),
                const SizedBox(height: 30),
                GoToChatButton(
                  buttonText: 'Go to Chat',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute( builder: (context) => const  EditProfileScreen(accountType: 'doctor',),));
                    // Navigator.push(
                    //   context,
                      // MaterialPageRoute(
                      //   builder: (context) => BlocProvider(
                      //     create: (_) => ChatCubit(initialMessages: [
                      //       ChatMessage(
                      //           isDoctor: false,
                      //           text: 'hi, can i book a session'),
                      //       ChatMessage(
                      //           isDoctor: true,
                      //           text: 'hi, yes but first we need to'),
                      //     ]),
                      //     child: ChatPage(doctorProfile: widget.doctorProfile),
                      //   ),
                      // ),
                    // );

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


