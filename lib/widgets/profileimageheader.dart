import 'package:flutter/material.dart';
import 'package:grad_app/cubit/profilecubit.dart';
import 'package:grad_app/models/profilestate.dart';

class ProfileImageHeader extends StatelessWidget {
  const ProfileImageHeader({
    super.key,
    required this.cubit, required this.state,
  });

  final ProfileCubit cubit;
  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: -7,
            left: -7,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap:
                  state.isPickingImage ? null : () => cubit.pickProfileImage(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.teal,
                    backgroundImage: state.profileImage != null
                        ? FileImage(state.profileImage!)
                        : null,
                    child: state.profileImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.black)
                        : null,
                  ),
                  if (state.isPickingImage)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
