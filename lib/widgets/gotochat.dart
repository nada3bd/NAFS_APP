import 'package:flutter/material.dart';

class GoToChatButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const GoToChatButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF009688),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      ),
      child: Text(buttonText,
          style: const TextStyle(fontSize: 16, color: Colors.white)),
    );
  }
}
