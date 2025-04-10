// ignore: file_names
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBackCubit extends Cubit<List<String>> {
  FeedBackCubit({List<String>? initialFeedback}) : super(initialFeedback ?? []);
  void addFeedback(String feedback) {
    final updated = List<String>.from(state)..add(feedback);
    emit(updated);
  }
}
