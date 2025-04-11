import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget implements PreferredSizeWidget {
  const CustomSafeArea({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
