import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/profilecubit.dart';
import 'package:grad_app/models/profilestate.dart';
import 'package:grad_app/widgets/build_circle.dart';
import 'package:grad_app/widgets/textfield.dart';
import 'package:grad_app/widgets/theme_button.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(top: -80, left: -80, child: buildCircle(150)),
            Positioned(top: -80, right: -80, child: buildCircle(150)),
            SafeArea(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  final cubit = context.read<ProfileCubit>();
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Center(child: Image.asset('assets/logo.png', height: 100)),
                        const SizedBox(height: 8),
                        CustomTextField(
                          label: "Full Name",
                          value: state.name,
                          icon: Icons.person,
                          onChanged: cubit.updateName,
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors.teal,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) cubit.updateDob(picked);
                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                              label: "Birthday",
                              value: state.dob == null
                                  ? ''
                                  : DateFormat('yyyy-MM-dd').format(state.dob!),
                              icon: Icons.calendar_today,
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          label: "Email",
                          value: state.email,
                          icon: Icons.email,
                          onChanged: cubit.updateEmail,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Gender", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                                  RadioListTile<String>(
                                    title: const Text('Male'),
                                    value: 'Male',
                                    groupValue: state.gender,
                                    onChanged: (val) => cubit.updateGender(val!),
                                    activeColor: Colors.teal,
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Female'),
                                    value: 'Female',
                                    groupValue: state.gender,
                                    onChanged: (val) => cubit.updateGender(val!),
                                    activeColor: Colors.teal,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Sign Up As", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                                  RadioListTile<String>(
                                    title: const Text('Doctor'),
                                    value: 'Doctor',
                                    groupValue: state.accountType,
                                    onChanged: (val) => cubit.updateAccountType(val!),
                                    activeColor: Colors.teal,
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Patient'),
                                    value: 'Patient',
                                    groupValue: state.accountType,
                                    onChanged: (val) => cubit.updateAccountType(val!),
                                    activeColor: Colors.teal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (state.accountType == 'Doctor') ...[
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                cubit.updateCertificate(File(pickedFile.path));
                              }
                            },
                            icon: const Icon(Icons.upload_file, color: Colors.white),
                            label: const Text("Upload Certificate", style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                          ),
                          if (state.certificate != null)
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.teal),
                                  SizedBox(width: 8),
                                  Expanded(child: Text("Certificate Selected", style: TextStyle(color: Colors.teal))),
                                ],
                              ),
                            ),
                        ],
                        const SizedBox(height: 8),
                        CustomTextField(
                          label: "Password",
                          icon: Icons.lock,
                          controller: _passwordController,
                          isPassword: true,
                          onChanged: (_) {},
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          label: "Confirm Password",
                          icon: Icons.lock_outline,
                          controller: _confirmPasswordController,
                          isPassword: true,
                          onChanged: (_) {},
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: state.acceptTerms,
                              onChanged: (val) => cubit.toggleAcceptTerms(),
                              activeColor: Colors.teal,
                            ),
                            const Expanded(child: Text("I accept all terms & conditions", style: TextStyle(color: Colors.black))),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: ThemedButton(
                            buttonText: "Sign Up",
                            onPressed: state.acceptTerms
                                ? () {
                                    if (_passwordController.text != _confirmPasswordController.text) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Passwords do not match'),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          margin: const EdgeInsets.all(16),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                      );
                                      return;
                                    }
                                  }
                                : null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                                Text("Sign in", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
