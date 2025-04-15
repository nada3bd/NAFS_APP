import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/postsstate.dart';
import 'package:grad_app/models/postsmodel.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  List<PostModel> posts = [];

  void loadPosts() {
    posts = [
      PostModel(
        id: '1',
        author: 'Dr.Nada Abu Al - Halaweh',
        content:
            'mbpoksvbnf l.dv dp v[f vlDvfdfllpb dvfbfkfbvblv vfghfbfbpfy, cfhgrjfgldfgyprrflijookfdbklpb ,mbpoksvbnf l.dv dp v[f vlDvfdfllpb dvfbfkfbvblv vfghfbfbpfy, cfhgrjfgldfgyprrflijookfdbklpb,mbpoksvbnf l.dv dp v[f vlDvfdfllpb dvfbfkfbvblv vfghfbfbpfy, cfhgrjfgldfgyprrflijookfdbklpb,mbpoksvbnf l.dv dp v[f vlDvfdfllpb dvfbfkfbvblv vfghfbfbpfy, cfhgrjfgldfgyprrflijookfdbklpb',
        timestamp: DateTime.now(),
        image: "assets/WhatsApp Image 2025-02-03 at 17.52.32_ee5e3371.jpg"
      ),
    ];
    emit(PostLoaded(posts));
  }

  void addPost(String content) {
    posts.add(
      PostModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: 'Dr.Nada Abu Al - Halaweh',
        content: content,
        timestamp: DateTime.now(),
        image: "assets/WhatsApp Image 2025-02-03 at 17.52.32_ee5e3371.jpg"
      ),
    );
    emit(PostLoaded(posts));
  }

  void deletePost(String id) {
    posts.removeWhere((post) => post.id == id);
    emit(PostLoaded(posts));
  }
}
