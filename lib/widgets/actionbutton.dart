// تعديل على: widgets/actionbutton.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postscubit.dart';

class ActionButton extends StatelessWidget {
  final String value;
  final TextEditingController? controller;
  final VoidCallback? onPressed;

 ActionButton({
    super.key,
    required this.value,
    this.controller,
    this.onPressed,
  });

  final Map<String, IconData> actionIcons = {
    'Save': Icons.save,
    'Add': Icons.add,
    'Publish': Icons.send,
    'Save Changes': Icons.save,
  };

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {
        final text = controller?.text.trim() ?? '';
        if (value == 'Publish' && text.isNotEmpty) {
          context.read<PostCubit>().addPost(text);
          Navigator.pop(context);
        }
      },
      icon: Icon(actionIcons[value] ?? Icons.help_outline, color: Colors.white),
      label: Text(value, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
