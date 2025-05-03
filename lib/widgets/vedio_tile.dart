// import 'package:flutter/material.dart';
// import 'package:grad_app/models/vedio_model.dart';

// class VideoTile extends StatelessWidget {
//   final VideoModel video;
//   final VoidCallback onTap;

//   const VideoTile({super.key, required this.video, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: const EdgeInsets.all(12),
//       leading: Stack(
//         alignment: Alignment.center,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(video.thumbnailUrl, width: 80, height: 80, fit: BoxFit.cover),
//           ),
//           const Icon(Icons.play_circle, color: Colors.white, size: 36),
//         ],
//       ),
//       title: Text(video.title, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
//       subtitle: Row(
//         children: [
//           const Icon(Icons.timer, size: 16, color: Colors.grey),
//           const SizedBox(width: 4),
//           Text(video.duration),
//         ],
//       ),
//       onTap: onTap,
//     );
//   }
// }
