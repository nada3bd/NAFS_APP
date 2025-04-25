import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/models/profilestate.dart';
import 'package:grad_app/widgets/theme_button.dart';
import 'package:grad_app/widgets/textfield.dart';

import 'package:intl/intl.dart';
import 'package:grad_app/cubit/profilecubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Center(child: Image.asset('assets/logo.png', height: 100)),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: "Full Name",
                    value: state.name,
                    icon: Icons.person,
                    onChanged: cubit.updateName,
                  ),
                  CustomTextField(
                    label: "Birthday",
                    value: DateFormat('yyyy-MM-dd').format(state.dob),
                    icon: Icons.calendar_today,
                    readOnly: true,
                    onChanged: (_) {},
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: state.dob,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) cubit.updateDob(picked);
                    },
                  ),
                  CustomTextField(
                    label: "Email",
                    value: state.email,
                    icon: Icons.email,
                    onChanged: cubit.updateEmail,
                  ),
                  CustomTextField(
                    label: "Gender",
                    value: state.gender,
                    icon: Icons.wc,
                    readOnly: true,
                    onChanged: (_) {},
                    onTap: () => cubit.updateGender(state.gender == 'Male' ? 'Female' : 'Male'),
                  ),
                  CustomTextField(
                    label: "Password",
                    value: '',
                    icon: Icons.lock,
                    onChanged: (_) {},
                  ),
                  CustomTextField(
                    label: "Confirm Password",
                    value: '',
                    icon: Icons.lock_outline,
                    onChanged: (_) {},
                  ),
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (_) {}),
                      const Expanded(child: Text("I accept all terms & conditions"))
                    ],
                  ),
                  const SizedBox(height: 8),
                  ThemedButton(
                    buttonText: "Sign Up",
                    onPressed: () {},
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Already have an account? Sign in"),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}