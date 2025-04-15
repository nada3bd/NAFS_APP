import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postscubit.dart';
import 'package:grad_app/models/postsmodel.dart';
import 'package:grad_app/views/editpostpage.dart';
import 'package:grad_app/widgets/expandableaboutme.dart';
import 'package:grad_app/widgets/infocard.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isDoctor;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const PostCard({
    super.key,
    required this.post,
    required this.isDoctor,
    this.onDelete,
    this.onEdit,
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
                CircleAvatar(
                    radius: 20, backgroundImage: AssetImage(post.image)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.author,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        '${post.timestamp.day} ${_monthName(post.timestamp.month)}, ${post.timestamp.hour}:${post.timestamp.minute.toString().padLeft(2, '0')} pm',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (isDoctor)
                  Theme(
                    data: Theme.of(context).copyWith(
                      popupMenuTheme: PopupMenuThemeData(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.teal), 
                        ),
                       
                      ),
                    ),
                    child: PopupMenuButton<String>(
                      constraints: const BoxConstraints.expand(width:62, height:100),
                      icon: const Icon(
                        Icons.more_vert,
                        size: 22,
                        color: Colors.teal,
                      ),
                      onSelected: (value) {
                        if (value == 'delete') {
                          onDelete?.call();
                        } else if (value == 'edit') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => BlocProvider.value(
                                value: BlocProvider.of<PostCubit>(context),
                                child: EditPostPage(post: post),
                              ),
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                            value: 'delete', child: Text('Delete'  ,style: TextStyle(fontSize: 10 , color: Colors.teal,))),
                        const PopupMenuItem(value: 'edit', child: Text('Edit' , style: TextStyle(fontSize:10  , color: Colors.teal))),
                      ],
                    ),
                  )
              ],
            ),
            const SizedBox(height: 8),
            InfoCard(
              color: const Color.fromARGB(255, 251, 251, 251),
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
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
