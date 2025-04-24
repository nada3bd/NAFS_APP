class ChatMessage {
  final bool isDoctor;
  final String text;
  final bool isImage;

  ChatMessage({
    required this.isDoctor,
    required this.text,
    this.isImage = false, 
  });
}
