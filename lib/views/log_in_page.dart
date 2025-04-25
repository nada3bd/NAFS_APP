
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/log_in_cubit.dart';
import 'package:grad_app/widgets/build_circle.dart';
import 'package:grad_app/widgets/log_in_form.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            Positioned(top: -100, left: -60, child: buildCircle(160)),
            Positioned(top: 100, right: -80, child: buildCircle(200)),
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: LoginForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}