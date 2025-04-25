import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/log_in_cubit.dart';
import 'package:grad_app/views/sign_up_page.dart';
import 'package:grad_app/widgets/logo.dart';
import 'package:grad_app/widgets/textfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoWidget(height: 180),
                  const SizedBox(height: 30),

                  CustomTextField(
                    label: "Email",
                    controller: emailController,
                    value: emailController.text,
                    icon: Icons.email,
                    onChanged: (v) {
                      emailController.text = v;
                      emailController.selection = TextSelection.fromPosition(
                        TextPosition(offset: emailController.text.length),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    label: "Password",
                    controller: passwordController,
                    value: passwordController.text,
                    icon: Icons.lock,
                    isPassword: true,
                    onChanged: (v) {
                      passwordController.text = v;
                      passwordController.selection = TextSelection.fromPosition(
                        TextPosition(offset: passwordController.text.length),
                      );
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      final isLoading = state is LoginLoading;
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();
                                  context.read<LoginCubit>().login(email, password);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Sign In",
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
                        Text("Sign up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}