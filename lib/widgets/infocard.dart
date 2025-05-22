import 'package:flutter/material.dart';


class InfoCard extends StatelessWidget {
  final dynamic content;
  final  Color? color ;

  const InfoCard({super.key, required this.content ,  this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
     
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color ??   Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ), 
      child: content is String ? Text(content) : content,
    );
  }
}
