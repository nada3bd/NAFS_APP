class DoctorProfile {
  final String name;
  final int rating;
  final String avatarIcon;
  final String aboutMe;
  final String sessionDuration;
  final String sessionPrice;
  final List<String> feedback;
  final String image;

  DoctorProfile({
    required this.image,
    required this.name,
    required this.rating,
    required this.avatarIcon,
    required this.aboutMe,
    required this.sessionDuration,
    required this.sessionPrice,
    required this.feedback,
  });

  //  void updateImage(String newImage) {
  //   image = newImage;
  // }

}