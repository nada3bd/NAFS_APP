import 'package:flutter/material.dart';

class AccountTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String?> onChanged;

  const AccountTypeSelector({super.key, required this.selectedType, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sign Up As", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
        RadioListTile<String>(
          title: const Text('Doctor'),
          value: 'Doctor',
          groupValue: selectedType,
          onChanged: onChanged,
          activeColor: Colors.teal,
        ),
        RadioListTile<String>(
          title: const Text('Patient'),
          value: 'Patient',
          groupValue: selectedType,
          onChanged: onChanged,
          activeColor: Colors.teal,
        ),
      ],
    );
  }
}