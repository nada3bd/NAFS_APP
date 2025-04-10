import 'package:flutter/material.dart';

class LabelBox extends StatelessWidget {
  final String title;
  final String value;

  const LabelBox({super.key, required this.title, required this.value, Color? color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: Text(value),
        ),
      ],
    );
  }
}
