import 'package:flutter/material.dart';

class DoctorHeader extends StatelessWidget {
  final String name;
  final int rating;
  final String image;
  const DoctorHeader({
    super.key,
    required this.name,
    required this.rating,
    required this.image,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: image.startsWith('http') ? NetworkImage(image) : AssetImage(image) as ImageProvider,
        ),
        const SizedBox(height: 10),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => Icon(Icons.star, color: index < rating ? Colors.amber : Colors.grey, size: 20)),
        ),
      ],
    );
  }
}
