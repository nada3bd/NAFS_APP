import 'package:flutter/material.dart';

class ThemeWriteEditPost extends StatelessWidget {
  const ThemeWriteEditPost({
    super.key,
    required TextEditingController controller,
    this.isEdit = false,
  }) : _controller = controller;

  final TextEditingController _controller;
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color(0xFFEEEEEE),
          cursorColor: Colors.black,
          selectionHandleColor: Colors.teal,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Material(
          color: Colors.grey[100],
          elevation: 6,
          borderRadius: BorderRadius.circular(16),
          shadowColor: Colors.grey,
          child: TextField(
            controller: _controller,
            minLines: 6,
            maxLines: isEdit ? null : null,
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
      ),
    );
  }
}
