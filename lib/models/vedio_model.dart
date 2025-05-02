class VideoModel {
  final String title;
  final String thumbnailUrl;
  final String videoId;
  final String duration;

  VideoModel({
    required this.title,
    required this.thumbnailUrl,
    required this.videoId,
    required this.duration,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json , String duration) {
    return VideoModel(
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['medium']['url'],
      videoId: json['id']['videoId'],
      duration: duration,
    );
  }
}
