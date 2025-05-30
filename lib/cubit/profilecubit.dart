import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grad_app/models/profilestate.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  
  void updateName(String value) => emit(state.copyWith(name: value));
  void updateEmail(String value) => emit(state.copyWith(email: value));
  void updateGender(String value) => emit(state.copyWith(gender: value));
  void updateDob(DateTime dob) => emit(state.copyWith(dob: dob));
  void updateMaritalStatus(String value) => emit(state.copyWith(maritalStatus: value));
  void updateMedicalConditions(String value) => emit(state.copyWith(medicalConditions: value));
  void updateEducation(String value) => emit(state.copyWith(educationLevel: value));
  void updateAbout(String value) => emit(state.copyWith(aboutMe: value));
  void updateSessionTime(String value) => emit(state.copyWith(sessionTime: value));
  void updatePrice(String value) => emit(state.copyWith(price: value));
  void updateLocation(String value) => emit(state.copyWith(location: value));

  Future<void> pickProfileImage() async {
    if (state.isPickingImage) return;

    emit(state.copyWith(isPickingImage: true));
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit(state.copyWith(profileImage: File(pickedFile.path)));
      }
    } catch (e) {
      emit(state.copyWith(errormassage: "Image not uploaded successfully!"));
    } finally {
      emit(state.copyWith(isPickingImage: false));
    }
  }

    void clearError() {
    emit(state.copyWith(errormassage: null)); 
  }


  void updateAccountType(String value) => emit(state.copyWith(accountType: value));

  void toggleAcceptTerms() => emit(state.copyWith(acceptTerms: !state.acceptTerms));

  void updateCertificate(File certificate) => emit(state.copyWith(certificate: certificate));

}
