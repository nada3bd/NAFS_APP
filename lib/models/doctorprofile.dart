class DoctorProfile {
  final String name;
  final int rating;
  final String avatarIcon;
  final String aboutMe;
  final String sessionDuration;
  final String sessionPrice;
  final String location;
  final String image;
  final List<String> feedback;

  DoctorProfile({
    required this.location,
    required this.feedback,
    required this.image,
    required this.name,
    required this.rating,
    required this.avatarIcon,
    required this.aboutMe,
    required this.sessionDuration,
    required this.sessionPrice, required String specialization,
  });
} 
  //  void updateImage(String newImage) {
  //   image = newImage;
  // }
  
