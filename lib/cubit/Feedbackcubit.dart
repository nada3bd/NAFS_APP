// ignore: file_names
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBackCubit extends Cubit<List<Map<String, String>>> {
  FeedBackCubit({List<Map<String, String>>? initialFeedback}) : super(initialFeedback ?? []);
  void addFeedback(String feedback) {
    final newFeedback = { 'message': feedback};
    final updatedList = List<Map<String, String>>.from(state);
    updatedList.add(newFeedback);
    emit(updatedList);
  }
}


  // void loadFeedbacksFromDatabase() async {
  //   await Future.delayed(const Duration(seconds: 1));

  //   // ignore: non_constant_identifier_names
  //   final Database = [
  //     {'name': 'unknown', 'message': 'دكتور رائع ومتعاون جداً'},
  //     {'name': 'unknown', 'message': 'ساعدني كثير بحالتي النفسية'},
  //     {'name': 'unknown', 'message': 'أنصح فيه'},
  //   ];

  //   emit( Database); 
  // }