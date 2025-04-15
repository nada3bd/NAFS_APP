import 'package:flutter/material.dart';

class ExpandableAboutMe extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableAboutMe({
    super.key,
    required this.text,
    this.maxLines = 3, Color? color,
  });

  @override
  ExpandableAboutMeState createState() => ExpandableAboutMeState();
}

class ExpandableAboutMeState extends State<ExpandableAboutMe> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Text(
        widget.text,
        maxLines: _expanded ? null : widget.maxLines,
        overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14 , color: Colors.grey[700]),
        textAlign: TextAlign.right,
      ),
    );
  }
}
