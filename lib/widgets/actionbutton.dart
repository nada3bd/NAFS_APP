import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
   ActionButton({
    super.key, required this.value,
  });
  final String value;
  final Map<String, IconData> actionIcons = {
  'save': Icons.save,
  'add': Icons.add,
  'publish': Icons.send,
};
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(actionIcons[value] ?? Icons.help_outline),
      label:  Text(value),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}
