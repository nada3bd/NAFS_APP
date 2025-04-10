import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/Feedbackcubit.dart';
import 'package:grad_app/models/doctorprofile.dart';
import 'package:grad_app/views/chatpage.dart';
import 'package:grad_app/widgets/customappbar.dart';
import 'package:grad_app/widgets/doctorheader.dart';
import 'package:grad_app/widgets/expandableaboutme.dart';
import 'package:grad_app/widgets/feedbacksection.dart';
import 'package:grad_app/widgets/gotochat.dart';
import 'package:grad_app/widgets/infocard.dart';
import 'package:grad_app/widgets/sectiontitle.dart';
import 'package:grad_app/widgets/sessionprice.dart';

class DoctorProfilePage extends StatefulWidget {
  final DoctorProfile doctorProfile;

  const DoctorProfilePage({super.key, required this.doctorProfile});

  @override
  // ignore: library_private_types_in_public_api
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _offsetAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedBackCubit(initialFeedback: widget.doctorProfile.feedback),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DoctorHeader(name: widget.doctorProfile.name, rating: widget.doctorProfile.rating, image: widget.doctorProfile.image),
              const SizedBox(height: 20),
              const SectionTitle(title: 'About me'),
              const SizedBox(height: 5),
              SlideTransition(
                position: _offsetAnimation,
                child: InfoCard(content: ExpandableAboutMe(text: widget.doctorProfile.aboutMe, maxLines: 3)),
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Feedback'),
              const SizedBox(height: 5),
              const FeedbackSection(),
              const SizedBox(height: 20),
              SessionPriceInfo(session: widget.doctorProfile.sessionDuration, price: widget.doctorProfile.sessionPrice),
              const SizedBox(height: 30),
              GoToChatButton(
                buttonText: 'Go to Chat',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
