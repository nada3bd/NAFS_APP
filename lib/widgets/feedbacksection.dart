import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/Feedbackcubit.dart';

import 'package:grad_app/widgets/infocard.dart';

class FeedbackSection extends StatefulWidget {
  const FeedbackSection({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _FeedbackSectionState createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<FeedbackSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return InfoCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<FeedBackCubit, List<String>>(
            builder: (context, feedbackList) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: feedbackList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(feedbackList[index], style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add your Feedback',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Feedback cannot be empty';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                if (_formKey.currentState!.validate()) {
                  context.read<FeedBackCubit>().addFeedback(value.trim());
                  _controller.clear();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
