import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/profilecubit.dart';
import 'package:grad_app/models/profilestate.dart';
import 'package:grad_app/widgets/accunt_type_selector.dart';
import 'package:grad_app/widgets/birthday_picekr.dart';
import 'package:grad_app/widgets/certificate_uploader.dart';
import 'package:grad_app/widgets/gender_selector.dart';
import 'package:grad_app/widgets/logo.dart';
import 'package:grad_app/widgets/textfield.dart';
import 'package:grad_app/widgets/theme_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key}); 

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const LogoWidget(),
              const SizedBox(height: 8),

              CustomTextField(
                label: "Full Name",
                value: state.name,
                icon: Icons.person,
                onChanged: cubit.updateName,
              ),
              const SizedBox(height: 8),

              BirthdayPicker(state: state, cubit: cubit),
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
                    child: GenderSelector(
                      selectedGender: state.gender,
                      onChanged: (val) {
                        if (val != null) cubit.updateGender(val);
                      },
                    ),
                  ),
                  Expanded(
                    child: AccountTypeSelector(
                      selectedType: state.accountType,
                      onChanged: (val) {
                        if (val != null) cubit.updateAccountType(val);
                      },
                    ),
                  ),
                ],
              ),

              if (state.accountType == 'Doctor')
                CertificateUploader(cubit: cubit, state: state),

              const SizedBox(height: 8),

              CustomTextField(
                label: "Password",
                controller: passwordController,
                icon: Icons.lock,
                isPassword: true,
                onChanged: (_) {},
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: "Confirm Password",
                controller: confirmPasswordController,
                icon: Icons.lock_outline,
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
                  const Expanded(
                    child: Text(
                      "I accept all terms & conditions",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Center(
                child: ThemedButton(
                  buttonText: "Sign Up",
                  onPressed: state.acceptTerms
                      ? () {
                          if (passwordController.text != confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Passwords do not match'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(16),
                                duration: const Duration(seconds: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
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
    );
  }
}
