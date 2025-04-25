import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grad_app/cubit/profilecubit.dart';
import 'package:grad_app/models/profilestate.dart';
import 'package:image_picker/image_picker.dart';

class CertificateUploader extends StatelessWidget {
  final ProfileCubit cubit;
  final ProfileState state;

  const CertificateUploader({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) cubit.updateCertificate(File(pickedFile.path));
      },
      icon: Icon(
        state.certificate == null ? Icons.upload_file : Icons.check_circle,
        color: Colors.white,
      ),
      label: Text(
        state.certificate == null ? "Upload Certificate" : "Certificate Selected",
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
    );
  }
}
