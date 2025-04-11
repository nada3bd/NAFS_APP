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


 