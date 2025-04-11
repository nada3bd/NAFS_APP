import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget implements PreferredSizeWidget {
  const CustomSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
