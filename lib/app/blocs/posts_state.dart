import '../models/posts_model.dart';

abstract class PostsState {}

class LoadingPosts implements PostsState {}

class PostsLoaded implements PostsState {
  final List<PostsModel> data;
  PostsLoaded(this.data);
}

class PostsError implements PostsState {
  final String message;
  PostsError(this.message);
}
