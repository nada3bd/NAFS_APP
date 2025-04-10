import 'package:flutter/material.dart';

class LabelBox extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const LabelBox({super.key, required this.title, required this.value, this.color = Colors.grey});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
          ),
          child: Text(value, style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7))),
        ),
      ],
    );
  }
}
