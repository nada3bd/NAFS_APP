import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class ActionButtonFeedback {

  static void validatePost(
    BuildContext context, {
    required String currentText,
    required bool isEdit,
    required VoidCallback onSuccess,
    String? originalText,
  }) {
    final trimmed = currentText.trim();
    final trimmedOriginal = originalText?.trim();

    if (trimmed.isEmpty) {
      _showFlush(
        context,
        message: "Post cannot be empty",
        icon: Icons.error_outline,
        color: Colors.redAccent,
      );
      return;
    }

    if (isEdit && trimmed == trimmedOriginal) {
      _showFlush(
        context,
        message: "No changes were made",
        icon: Icons.warning_amber_outlined,
        color: Colors.orange,
      );
      return;
    }

    _showSuccessFlush(
      context,
      message: isEdit ? "Post updated successfully" : "Post published successfully",
      onDismissed: onSuccess,
    );
  }
  static void _showFlush(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color color,
  }) {
    Flushbar(
      messageText: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      flushbarPosition: FlushbarPosition.TOP,
      leftBarIndicatorColor: color,
    ).show(context);
  }
  static void _showSuccessFlush(
    BuildContext context, {
    required String message,
    required VoidCallback onDismissed,
  }) {
    Flushbar(
      messageText: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      flushbarPosition: FlushbarPosition.TOP,
      leftBarIndicatorColor: Colors.green,
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED && context.mounted) {
          onDismissed();
        }
      },
    ).show(context);
  }
}
