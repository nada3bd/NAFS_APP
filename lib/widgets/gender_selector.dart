import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderSelector({super.key, required this.selectedGender, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gender", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
        RadioListTile<String>(
          title: const Text('Male'),
          value: 'Male',
          groupValue: selectedGender,
          onChanged: onChanged,
          activeColor: Colors.teal,
        ),
        RadioListTile<String>(
          title: const Text('Female'),
          value: 'Female',
          groupValue: selectedGender,
          onChanged: onChanged,
          activeColor: Colors.teal,
        ),
      ],
    );
  }
}