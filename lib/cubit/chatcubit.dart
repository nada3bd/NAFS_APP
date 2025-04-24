import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/models/chatpage.dart';


class ChatCubit extends Cubit<List<ChatMessage>> {
  ChatCubit({List<ChatMessage>? initialMessages}) : super(initialMessages ?? []);
  void addMessage(String text, bool isDoctor) {
    final msg = ChatMessage(isDoctor: isDoctor, text: text);
    emit(List.from(state)..add(msg));
  }

void addImageMessage(String imagePath, bool isDoctor) {
  final msg = ChatMessage(
    isDoctor: isDoctor,
    text: imagePath,
    isImage: true,
  );
  emit(List.from(state)..add(msg));
}



}
