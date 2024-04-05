import '../models/comments_model.dart';
import '../models/posts_model.dart';

abstract class CommentsState {}

class LoadingComments implements CommentsState {}

class CommentsLoaded implements CommentsState {
  final List<CommentsModel> data;
  final PostsModel post;
  CommentsLoaded(this.data, this.post);
}

class ErrorComments implements CommentsState {
  final String message;
  ErrorComments(this.message);
}
