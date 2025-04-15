import 'package:flutter/material.dart';

class ThemeForWritePost extends StatelessWidget {
  const ThemeForWritePost({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ) ,
        
      ),
      child: Material(
        color: Colors.grey[100],
        elevation: 6,
        borderRadius: BorderRadius.circular(16),
        shadowColor: Colors.grey,
        child: TextField(
          controller: _controller,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: 'What do you want to talk about?',
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
