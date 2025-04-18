import 'package:flutter/material.dart';

class ThemeWriteEditPost extends StatelessWidget {
  const ThemeWriteEditPost({
    super.key,
    required this.controller,
    this.isEdit = false,
    required this.authorName,
    required this.authorImage,
  });

  final TextEditingController controller;
  final bool isEdit;
  final String authorName;
  final String authorImage;

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
      child: Card(
        margin: const EdgeInsets.only( top :40 ,  bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only( top : 12 , bottom:20, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.teal,
                    backgroundImage: authorImage.isNotEmpty ? AssetImage(authorImage) : null,
                    child: authorImage.isEmpty
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      authorName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Material(
                color: Colors.grey[50],
                elevation: 6,
                borderRadius: BorderRadius.circular(16),
                shadowColor: Colors.grey,
                child: TextField(
                  controller: controller,
                  minLines:15,
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
            ],
          ),
        ),
      ),
    );
  }
}
