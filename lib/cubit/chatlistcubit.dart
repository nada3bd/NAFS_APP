import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/models/chatlistcontact.dart';

class ChatListCubit extends Cubit<List<ChatContactModel>> {
  ChatListCubit() : super([]);

  void loadChatsForDoctor() {
    emit([
       ChatContactModel(
        name: "Ali Ahmad",
        message: "what does it mean?",
        time: DateTime.now(),
        image: "assets/patient1.png",
      ),
      ChatContactModel(
        name: "Alice",
        message: "is that even worth it !",
        time:  DateTime.now(),
        image: "assets/patient2.png",
      ), 
      ChatContactModel(
        name: "Ali Ahmad",
        message: "what does it mean?",
        time: DateTime.now(),
        image: "assets/patient1.png",
      ),
      ChatContactModel(
        name: "Alice",
        message: "is that even worth it !",
        time:  DateTime.now(),
        image: "assets/patient2.png",
      ),ChatContactModel(
        name: "Ali Ahmad",
        message: "what does it mean?",
        time: DateTime.now(),
        image: "assets/patient1.png",
      ),
      ChatContactModel(
        name: "Alice",
        message: "is that even worth it !",
        time:  DateTime.now(),
        image: "assets/patient2.png",
      ),ChatContactModel(
        name: "Ali Ahmad",
        message: "what does it mean?",
        time: DateTime.now(),
        image: "assets/patient1.png",
      ),
      ChatContactModel(
        name: "Alice",
        message: "is that even worth it !",
        time:  DateTime.now(),
        image: "assets/patient2.png",
      ),ChatContactModel(
        name: "Ali Ahmad",
        message: "what does it mean?",
        time: DateTime.now(),
        image: "assets/patient1.png",
      ),
      ChatContactModel(
        name: "Alice",
        message: "is that even worth it !",
        time:  DateTime.now(),
        image: "assets/patient2.png",
      ),ChatContactModel(
        name: "Ali Ahmad",
        message: "what does it mean?",
        time: DateTime.now(),
        image: "assets/patient1.png",
      ),
      ChatContactModel(
        name: "Alice",
        message: "is that even worth it !",
        time:  DateTime.now(),
        image: "assets/patient2.png",
      ),ChatContactModel(
        name: "Ali Ahmad",
        message: "what does it mean?",
        time: DateTime.now(),
        image: "assets/patient1.png",
      ),
      ChatContactModel(
        name: "Alice",
        message: "is that even worth it !",
        time:  DateTime.now(),
        image: "assets/patient2.png",
      ),ChatContactModel(
        name: "Ali Ahmad",
        message: "what does it mean?",
        time: DateTime.now(),
        image: "assets/patient1.png",
      ),
      ChatContactModel(
        name: "Alice",
        message: "is that even worth it !",
        time:  DateTime.now(),
        image: "assets/patient2.png",
      ),
      
    ]);
  }

  void loadChatsForPatient() {
    emit([
      ChatContactModel(
        name: "Dr. Ruba Abed",
        message: "what does it mean? ..",
        time: DateTime.now() ,
        image: "grad_app/assets/WhatsApp Image 2025-02-03 at 17.52.32_ee5e3371.jpg",
      ),
     
    ]);
  }
}
