 import 'package:flutter/material.dart';

Widget buildCircle(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.teal,
      ),
    );
  }