
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/profilecubit.dart';
import 'package:grad_app/widgets/build_circle.dart';
import 'package:grad_app/widgets/sign_up_form.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(top: -80, left: -80, child: buildCircle(150)),
            Positioned(top: -80, right: -80, child: buildCircle(150)),
            const SafeArea(child: SignUpForm()),
          ],
        ),
      ),
    );
  }
}
