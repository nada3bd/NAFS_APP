import 'dart:io';

class ProfileState {
  final String name;
  final String email;
  final String gender;
  final DateTime? dob;
  final File? profileImage;
  final String maritalStatus;
  final String medicalConditions;
  final String educationLevel;
  final String aboutMe;
  final String sessionTime;
  final String price;
  final String location;
  final bool isPickingImage;
  final String? errormassage;
  final String accountType;
  final bool acceptTerms;
  final File? certificate;

  ProfileState({
    this.name = '',
    this.email = '',
    this.gender = '',
    this.dob, 
    this.profileImage,
    this.maritalStatus = '',
    this.medicalConditions = '',
    this.educationLevel = '',
    this.aboutMe = '',
    this.sessionTime = '',
    this.price = '',
    this.location = '',
    this.isPickingImage = false,
    this.errormassage,
    this.accountType = '',
    this.acceptTerms = false,
    this.certificate,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? gender,
    DateTime? dob,
    File? profileImage,
    String? maritalStatus,
    String? medicalConditions,
    String? educationLevel,
    String? aboutMe,
    String? sessionTime,
    String? price,
    String? location,
    bool? isPickingImage,
    String? errormassage,
    String? accountType,
    bool? acceptTerms,
    File? certificate,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      profileImage: profileImage ?? this.profileImage,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      educationLevel: educationLevel ?? this.educationLevel,
      aboutMe: aboutMe ?? this.aboutMe,
      sessionTime: sessionTime ?? this.sessionTime,
      price: price ?? this.price,
      location: location ?? this.location,
      isPickingImage: isPickingImage ?? this.isPickingImage,
      errormassage: errormassage ?? this.errormassage,
      accountType: accountType ?? this.accountType,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      certificate: certificate ?? this.certificate,
    );
  }
}
