class PostModel {
  final String id;
  final String author;
  final String content;
  final DateTime timestamp;
  final String image;

  PostModel({
    required this.image,
    required this.id,
    required this.author,
    required this.content,
    required this.timestamp,
  });
}