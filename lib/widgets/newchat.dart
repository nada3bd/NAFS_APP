import 'package:flutter/material.dart';

class NewMessageIndicator extends StatelessWidget {
  final VoidCallback onTap;

  const NewMessageIndicator({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 12, 12, 12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'New Message',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
