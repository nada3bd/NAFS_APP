import 'package:flutter/material.dart';
import 'package:grad_app/models/postsmodel.dart';
import 'package:grad_app/widgets/expandableaboutme.dart';
import 'package:grad_app/widgets/infocard.dart';


class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isDoctor;
  final VoidCallback? onDelete;

  const PostCard({
    super.key,
    required this.post,
    required this.isDoctor,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 20,  backgroundImage : AssetImage(post.image)  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.author,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        '${post.timestamp.day} ${_monthName(post.timestamp.month)}, ${post.timestamp.hour}:${post.timestamp.minute.toString().padLeft(2, '0')} pm',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (isDoctor)
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete') {
                        onDelete?.call();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 8),
            InfoCard(
                    color: Colors.grey[130],
                    content: ExpandableAboutMe(
                      text: post.content,
                      maxLines: 3,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
