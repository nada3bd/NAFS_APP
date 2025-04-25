import 'package:flutter/material.dart';
import 'package:grad_app/views/log_in_page.dart';
import 'package:grad_app/views/sign_up_page.dart';
import 'package:grad_app/widgets/build_circle.dart';
import 'package:grad_app/widgets/theme_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(top: -100, left: -60, child: buildCircle(160 )),
          Positioned(top: 100, right: -80, child: buildCircle(200 )),
          Positioned(bottom: -30, left: -40, child: buildCircle(150)),
         

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 240),
                  const SizedBox(height: 20),
                  const Text(
                    'Smart Care\nFor a Healthier You.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ThemedButton(
                          buttonText: 'Sign Up',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignUpPage()),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ThemedButton(
                          buttonText: 'Sign In',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 

}
