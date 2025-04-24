import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/chatcubit.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickAndSendImage(ImageSource source, BuildContext context, bool isDoctor) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);

  if (image != null) {
    // ignore: use_build_context_synchronously
    context.read<ChatCubit>().addImageMessage(image.path, isDoctor);
  }
}
