import 'package:flutter/material.dart';

int calculateLineCount(String text, TextStyle style, double maxWidth) {
  final lines = text.split('\n');
  int totalLines = 0;

  for (final line in lines) {
    final span = TextSpan(text: line, style: style);
    final tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: maxWidth);
    totalLines += tp.computeLineMetrics().length;
  }

  return totalLines;
}
