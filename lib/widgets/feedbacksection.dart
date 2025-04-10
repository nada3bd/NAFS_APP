import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/Feedbackcubit.dart';
import 'package:grad_app/widgets/infocard.dart';

class FeedbackSection extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  FeedbackSection({super.key, required List<String> feedbackList});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          BlocBuilder<FeedBackCubit, List<Map<String, String>>>(
            builder: (context, feedbackList) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: feedbackList.map((fb) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${fb['name']}', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '  ${fb['message']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 136, 136, 136),
                        thickness: 1,
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Add your Feedback',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                context.read<FeedBackCubit>().addFeedback(value.trim()); 
                _controller.clear(); 
              }
            },
          ),
        ],
      ),
    );
  }
}
